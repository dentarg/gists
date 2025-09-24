threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
workers_count = Integer(ENV['WEB_CONCURRENCY'] || 1)
threads threads_count, threads_count

# require "localhost"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
# port ENV.fetch("PORT", 3000)
bind 'ssl://localhost:3000'

# Specifies the `environment` that Puma will run in.
environment ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'

if workers_count > 1
  workers workers_count
  prune_bundler
  fork_worker
end

# Allow puma to be restarted by `bin/rails restart` command.
# plugin :tmp_restart

# Run the Solid Queue supervisor inside of Puma for single-server deployments
# plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# Specify the PID file. Defaults to tmp/pids/server.pid in development.
# In other environments, only set the PID file if requested.
# pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

