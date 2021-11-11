require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "net-ssh", "6.1.0"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end

class Vagrant
  class << self
    def method_missing(*)
      self
    end
  end

  def method_missing(*)
    self
  end
end

require "/opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/lib/vagrant/patches/net-ssh.rb"

require "net/ssh"

ssh_info = {
  host: "127.0.0.1",
  username: "vagrant",
}
connect_opts = {
  port: 2222,
  verbose: :debug,
  keys: "/Users/dentarg/.vagrant.d/insecure_private_key",
  auth_methods: ["publickey"]
}

Net::SSH.start(ssh_info[:host], ssh_info[:username], connect_opts)
