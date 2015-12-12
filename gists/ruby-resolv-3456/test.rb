require "resolv"

puts RUBY_DESCRIPTION

host = "http://Disaster.MY"

resolver = Resolv::DNS.new(nameserver: ["8.8.8.8", "8.8.4.4"])

resolver.getname("64.4.6.100")

addresses = resolver.getaddresses(host).map(&:to_s)
