# Vagrant

How to Vagrant on macOS arm64.

Uses https://developer.hashicorp.com/vagrant/docs/providers/vmware

```shell
brew install --cask vagrant
brew install --cask vagrant-vmware-utility
vagrant plugin install vagrant-vmware-desktop
sudo launchctl enable system/com.vagrant.vagrant-vmware-utility
vagrant status
vagrant up
```
