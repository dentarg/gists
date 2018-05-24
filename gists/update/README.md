Atom / APM

    apm outdated

    apm upgrade --no-confirm

Vagrant boxes

    ./box-update

    ./box-clean

Remove machine from `vagrant global-status`

```sh
# List machines
./vagrant-clean

# Remove machine from index
./vagrant-clean 22f0b115968b491abaf49876226536d3
```

VirtualBox cleanup

```sh
# List VMs
./vbox-list

# Power off and delete VM
./vbox-destroy b9481fbc-8461-443c-9598-0b1eeaa6e2c9
```
