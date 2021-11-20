require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "net-ssh", github: "net-ssh/net-ssh"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end

class Vagrant
  class << self
    def global_logger
      self.new
    end
  end

  def method_missing(symbol, *args)
    puts "Vagrant.global_logger #{symbol.upcase} #{args}"
  end
end

# require "/opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/lib/vagrant/patches/net-ssh.rb"
# require_relative "patches/net-ssh.backup"
# require_relative "patches/net-ssh"

require "net/ssh"

ssh_info = {
  host: "127.0.0.1",
  username: "vagrant",
}
connect_opts = {
  port: 2222,
  verbose: :debug,
  keys: "/Users/dentarg/.vagrant.d/insecure_private_key",
  keys_only: true,
  auth_methods: ["publickey"]
}

Net::SSH.start(ssh_info[:host], ssh_info[:username], connect_opts)
