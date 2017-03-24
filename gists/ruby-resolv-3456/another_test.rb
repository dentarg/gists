p RUBY_VERSION
require 'resolv'
google = [["8.8.8.8", 53], ["8.8.4.4", 53]]
gresolver = Resolv::DNS.new(nameserver_port: google)
gresolver.getname("69.156.240.29")
