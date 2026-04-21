# sentry-ruby Rake integration captures SignalException on SIGTERM

`bundle exec ruby reproduce.rb 2>/dev/null`

## Summary

On Heroku (and any Unix host) dynos running a rake task receive `SIGTERM`
when they are asked to shut down. Ruby's default handler for `SIGTERM`
raises `SignalException`. Rake's `standard_exception_handling` sees it
as a regular `Exception`, calls `display_error_message`, and then exits.

`sentry-ruby` prepends `Sentry::Rake::Application#display_error_message`
onto `Rake::Application` and calls `Sentry.capture_exception` there
([`lib/sentry/rake.rb`][rake.rb]). Result: every graceful dyno shutdown
that happens while a rake task is running produces a noisy Sentry event.

Neither `SignalException` nor `SystemExit` is in
`Sentry::Configuration::IGNORE_DEFAULT`, so users do not get
protection out of the box.

This feels like something the integration itself should know about —
`SignalException` is not an application error, it's a process
lifecycle signal.

[rake.rb]: https://github.com/getsentry/sentry-ruby/blob/master/sentry-ruby/lib/sentry/rake.rb

## Reproduce

```
bundle install
bundle exec ruby reproduce.rb
```

Expected output (the `sigterm` scenario is the bug):

```
scenario: rake sigterm
  captured 1 sentry event(s)
    - SignalException: SIGTERM (SignalException)

scenario: rake system_exit
  captured 0 sentry event(s)

scenario: rake boom
  captured 1 sentry event(s)
    - RuntimeError: something actually broke (RuntimeError)
```

Note that `system_exit` is correctly silent — Rake has a dedicated
`rescue SystemExit` branch in `standard_exception_handling` that
re-raises before `display_error_message` is called, so Sentry's patch
never fires. `SignalException` has no such branch.

## Workarounds users have to apply today

Either:

1. Add `SignalException` (and `SystemExit`) to
   `config.excluded_exceptions` in `Sentry.init`.
2. Trap the signal in the task process so it becomes `SystemExit`,
   which Rake already handles silently:

   ```ruby
   Signal.trap("TERM") { exit }
   ```

   This is what we ended up doing
   ([customer-console#1507](https://github.com/84codes/customer-console/pull/1507)).

## Suggested fix

Either:

- Add `SignalException` and `SystemExit` to
  `Sentry::Configuration::IGNORE_DEFAULT`.
- Or, in `Sentry::Rake::Application#display_error_message`, skip the
  capture when `ex.is_a?(SignalException) || ex.is_a?(SystemExit)`
  (narrower, keeps IGNORE_DEFAULT for the general filtering list).

## Environment

- sentry-ruby 5.25+ (reproduced on 5.28.1)
- rake 13.x
- ruby 3.x
