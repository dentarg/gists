# frozen_string_literal: true

require "bundler/inline"

use_sequel_pg = ARGV.first == "sequel_pg"

gemfile(install = true) do
  source "https://rubygems.org"
  gem "benchmark"
  gem "sequel", "5.96.0"
  gem "sequel_pg", "1.17.2", require: "sequel" if use_sequel_pg
  gem "pg", "1.6.2", force_ruby_platform: %w[1 true].include?(ENV["force_ruby_platform"])
end

DB_NAME = "sequel_pg_benchmark_#{rand(100)}"

url = ENV.fetch("URL") do
  system "createdb #{DB_NAME}"
  "postgres://localhost/#{DB_NAME}"
end

begin
  puts "Connecting to #{url}"
  puts "Using sequel_pg" if use_sequel_pg
  puts

  Sequel.connect(url) do |db|
    puts db.select { version.function }.all
    db.extension :pg_streaming if use_sequel_pg
    db.run "CREATE TABLE tracks (id serial, title text)"
    db.run "CREATE TABLE albums (id serial, title text)"
    rows = [ { title: "foo bar baz" }] * 10_000
    db[:tracks].multi_insert(rows * 100) # 1M
    db[:albums].multi_insert(rows * 10)  # 100K

    puts Benchmark.measure { db[:tracks].each {} }
    puts Benchmark.measure { db[:albums].each {} }
  end
ensure
  system "dropdb #{DB_NAME}"
end
