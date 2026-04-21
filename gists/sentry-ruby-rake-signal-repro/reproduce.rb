# frozen_string_literal: true

# Standalone reproducer for sentry-ruby's Rake integration capturing
# SignalException as a Sentry event.
#
# When a rake task process receives SIGTERM (e.g. Heroku dyno shutdown),
# Ruby raises SignalException. Rake's `standard_exception_handling`
# routes it through `display_error_message`, which `sentry-ruby` patches
# in `lib/sentry/rake.rb` to call `Sentry.capture_exception`.
#
# The result: every graceful dyno shutdown that happens while a rake
# task is running produces a noisy Sentry event.
#
# Run with:
#   bundle install
#   bundle exec ruby reproduce.rb

require "bundler/setup"
require "rake"
require "sentry-ruby"

Sentry.init do |config|
  config.dsn = "https://public@example.com/1"
  config.transport.transport_class = Sentry::DummyTransport
  config.background_worker_threads = 0
  config.sdk_logger = Logger.new(IO::NULL)
end

def run_task(name)
  events = Sentry.get_current_client.transport.events
  events.clear

  app = Rake::Application.new
  Rake.application = app
  app.init("reproduce.rb")
  app.load_rakefile
  app.top_level_tasks.replace([name.to_s])

  begin
    app.standard_exception_handling { Rake::Task[name].invoke }
  rescue SystemExit
    # Rake's `rescue SystemExit` branch re-raises; swallow so we keep going.
  end

  puts "scenario: rake #{name}"
  puts "  captured #{events.size} sentry event(s)"
  events.each do |ev|
    ev.exception.values.each do |v|
      puts "    - #{v.type}: #{v.value}"
    end
  end
  puts
end

puts "sentry-ruby #{Sentry::VERSION}, rake #{Rake::VERSION}, ruby #{RUBY_VERSION}"
puts

run_task(:sigterm)     # EXPECTED: 0 events.  ACTUAL: 1 event (the bug).
run_task(:system_exit) # EXPECTED: 0 events.  ACTUAL: 0 events (Rake handles this silently).
run_task(:boom)        # EXPECTED: 1 event.   ACTUAL: 1 event (control, correct).
