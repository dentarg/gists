Atom / APM

    apm outdated

    apm upgrade --no-confirm


Vagrant boxes

    vagrant box list | awk '{ print $1 }' | while read box; do ; vagrant box update --box $box ; done
