# frozen_string_literal: true

$stdout.sync = true
$stderr.sync = true

run lambda { |env|
  body = +"#{'─' * 70} Headers\n"
  env.sort.each { |k,v| body << "#{k.ljust 30} #{v}\n" }
  body << "#{'─' * 78}\n"

  request = Rack::Request.new(env)
  body << "#{'request.ip'.ljust(30)} #{request.ip}\n"
  body << "#{'request.forwarded_for'.ljust(30)} #{request.forwarded_for}\n"

  body << "#{'─' * 78}\n"

  [200, {"Content-Type" => "text/plain"}, [body]]
}
