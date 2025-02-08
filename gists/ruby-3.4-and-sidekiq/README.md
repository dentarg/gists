# Ruby 3.4 and embedded Sidekiq

```ruby
$ cat config/puma.rb
# frozen_string_literal: true

require_relative "sidekiq" unless %w[1 true].include?(ENV["NO_SIDEKIQ"])

port ENV.fetch("PORT", 3000).to_i
```

```ruby
$ cat config/sidekiq.rb
# frozen_string_literal: true

require "logger"
require "sidekiq"
require "sidekiq/launcher"

require_relative "../lib/bgp_worker"

config = Sidekiq.default_configuration
config.logger.level = Logger::DEBUG
config.redis = {
  url: ENV.fetch("SIDEKIQ_REDIS_URL", "redis://localhost:6379/1"),
}

# Avoid Sidekiq heartbeat commands to Redis (exhausting Upstash quota)
# Sidekiq::Embedded#run does not take any arguments, so use Launcher directly
# https://github.com/sidekiq/sidekiq/blob/v7.2.1/lib/sidekiq/launcher.rb#L35-L38
# https://github.com/sidekiq/sidekiq/blob/v7.2.1/lib/sidekiq/embedded.rb#L13
embedded_sidekiq = Sidekiq::Launcher.new(config, embedded: true)
embedded_sidekiq.run(async_beat: false)
sleep 0.2 # pause to give threads time to spin up
```

```bash
$ dotenv -f .env.test_a bundle exec puma --port 5050 --log-requests
2025-02-08T10:01:18.028Z pid=9441 tid=6nl INFO: Sidekiq 7.3.8 connecting to Redis with options {size: 10, pool_name: "internal", url: "redis://localhost:6379/1"}
2025-02-08T10:01:18.028Z pid=9441 tid=6nl DEBUG: {labels: #<Set: {}>, require: ".", environment: nil, concurrency: 5, timeout: 25, poll_interval_average: nil, average_scheduled_poll_interval: 5, on_complex_arguments: :raise, iteration: {max_job_runtime: nil, retry_backoff: 0}, error_handlers: [#<Proc:0x000000010287da90 /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:43 (lambda)>], death_handlers: [], lifecycle_events: {startup: [], quiet: [], shutdown: [], heartbeat: [], beat: []}, dead_max_jobs: 10000, dead_timeout_in_seconds: 15552000, reloader: #<Proc:0x000000010287db30 /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:39>, backtrace_cleaner: #<Proc:0x000000010287dae0 /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:40 (lambda)>}
Puma starting in single mode...
* Puma version: 6.6.0 ("Return to Forever")
* Ruby version: ruby 3.4.1 (2024-12-25 revision 48d4efcb85) +PRISM [arm64-darwin23]
*  Min threads: 0
*  Max threads: 5
*  Environment: development
*          PID: 9441
* Listening on http://0.0.0.0:5050
Use Ctrl-C to stop
127.0.0.1 - - [08/Feb/2025:11:01:21 +0100] "GET / HTTP/1.1" 200 3 0.0094
127.0.0.1 - - [08/Feb/2025:11:01:21 +0100] "GET / HTTP/1.1" 200 3 0.0009


^C- Gracefully stopping, waiting for requests to finish
=== puma shutdown: 2025-02-08 11:01:25 +0100 ===
- Goodbye!
2025-02-08T10:01:25.552Z pid=9441 tid=6ip WARN: {"context":"scheduler"}
2025-02-08T10:01:25.552Z pid=9441 tid=6ip WARN: ThreadError: can't alloc thread
2025-02-08T10:01:25.552Z pid=9441 tid=6ip WARN: /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:711:in 'Thread.new'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:711:in 'block in Socket.tcp_with_fast_fallback'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:709:in 'Array#map'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:709:in 'Socket.tcp_with_fast_fallback'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:661:in 'Socket.tcp'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/ruby_connection.rb:120:in 'RedisClient::RubyConnection#connect'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/ruby_connection.rb:51:in 'RedisClient::RubyConnection#initialize'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:759:in 'Class#new'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:759:in 'block in RedisClient#connect'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/middlewares.rb:12:in 'RedisClient::BasicMiddleware#connect'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:758:in 'RedisClient#connect'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:745:in 'RedisClient#raw_connection'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:705:in 'RedisClient#ensure_connected'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:285:in 'RedisClient#call'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/redis_client_adapter.rb:36:in 'block (2 levels) in <module:CompatMethods>'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:196:in 'block in Sidekiq::Scheduled::Poller#cleanup'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:175:in 'block in Sidekiq::Config#redis'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:110:in 'block (2 levels) in ConnectionPool#with'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:109:in 'Thread.handle_interrupt'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:109:in 'block in ConnectionPool#with'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:106:in 'Thread.handle_interrupt'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:106:in 'ConnectionPool#with'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:172:in 'Sidekiq::Config#redis'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:28:in 'Sidekiq::Component#redis'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:196:in 'Sidekiq::Scheduled::Poller#cleanup'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:232:in 'Sidekiq::Scheduled::Poller#initial_wait'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:96:in 'block in Sidekiq::Scheduled::Poller#start'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:10:in 'Sidekiq::Component#watchdog'
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:19:in 'block in Sidekiq::Component#safe_thread'
#<Thread:0x000000011ded1a20@sidekiq.scheduler /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:17 aborting> terminated with exception (report_on_exception is true):
/Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:711:in 'Thread.new': can't alloc thread (ThreadError)
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:711:in 'block in Socket.tcp_with_fast_fallback'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:709:in 'Array#map'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:709:in 'Socket.tcp_with_fast_fallback'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/3.4.0/socket.rb:661:in 'Socket.tcp'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/ruby_connection.rb:120:in 'RedisClient::RubyConnection#connect'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/ruby_connection.rb:51:in 'RedisClient::RubyConnection#initialize'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:759:in 'Class#new'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:759:in 'block in RedisClient#connect'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client/middlewares.rb:12:in 'RedisClient::BasicMiddleware#connect'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:758:in 'RedisClient#connect'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:745:in 'RedisClient#raw_connection'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:705:in 'RedisClient#ensure_connected'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/redis-client-0.23.2/lib/redis_client.rb:285:in 'RedisClient#call'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/redis_client_adapter.rb:36:in 'block (2 levels) in <module:CompatMethods>'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:196:in 'block in Sidekiq::Scheduled::Poller#cleanup'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:175:in 'block in Sidekiq::Config#redis'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:110:in 'block (2 levels) in ConnectionPool#with'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:109:in 'Thread.handle_interrupt'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:109:in 'block in ConnectionPool#with'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:106:in 'Thread.handle_interrupt'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/connection_pool-2.5.0/lib/connection_pool.rb:106:in 'ConnectionPool#with'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/config.rb:172:in 'Sidekiq::Config#redis'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:28:in 'Sidekiq::Component#redis'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:196:in 'Sidekiq::Scheduled::Poller#cleanup'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:232:in 'Sidekiq::Scheduled::Poller#initial_wait'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/scheduled.rb:96:in 'block in Sidekiq::Scheduled::Poller#start'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:10:in 'Sidekiq::Component#watchdog'
	from /Users/dentarg/.arm64_rubies/3.4.1/lib/ruby/gems/3.4.0/gems/sidekiq-7.3.8/lib/sidekiq/component.rb:19:in 'block in Sidekiq::Component#safe_thread'
```
