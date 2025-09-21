# frozen_string_literal: true

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "sequel", "5.96.0"
  gem "sequel_pg", "1.17.2", require: "sequel"
  gem "pg", "1.6.2", force_ruby_platform: %w[1 true].include?(ENV["force_ruby_platform"])
end

DB_NAME = "foo_#{rand(100)}"

url = ENV.fetch("URL") do
  system "createdb #{DB_NAME}"
  "postgres://localhost/#{DB_NAME}"
end

begin
  puts "Connecting to #{url}"
  Sequel.connect(url) do |db|
    puts db.select { version.function }.all
    db.extension :pg_streaming
    db.run "CREATE TABLE foo (id serial)"
    db[:foo].stream.each {}
  end
ensure
  system "dropdb #{DB_NAME}"
end
