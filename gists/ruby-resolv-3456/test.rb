require "resolv"

puts RUBY_DESCRIPTION

resolver = Resolv::DNS.new(nameserver: ["8.8.8.8", "8.8.4.4"])
resolver.getname("64.4.6.100")
