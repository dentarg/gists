# frozen_string_literal: true

workers 2
threads 16, 16

preload_app!

port        ENV["PORT"]     || 3000
environment ENV["RACK_ENV"] || "development"

app do |env|
  body = 'Hello, World!'
  [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body]]
end
