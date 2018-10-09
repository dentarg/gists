#!/bin/sh

set -u # stop on unset variables
set -e # stop on error
set -x # echo commands

# http://askubuntu.com/questions/656769/how-to-set-a-default-option-for-dpkg-configure-a
#
#   dpkg --configure -a --force-confnew

# https://raphaelhertzog.com/2010/09/21/debian-conffile-configuration-file-managed-by-dpkg/
#
# Avoiding the conffile prompt
#
# Every time that dpkg must install a new conffile that you have modified
# (and a removed file is only a particular case of a modified file in
# dpkg’s eyes), it will stop the upgrade and wait your answer. This can be
# particularly annoying for major upgrades. That’s why you can give
# predefined answers to dpkg with the help of multiple --force-conf*
# options:
#
# * --force-confold: do not modify the current configuration file, the new
#   version is installed with a .dpkg-dist suffix. With this option alone,
#   even configuration files that you have not modified are left
#   untouched. You need to combine it with --force-confdef to let dpkg
#   overwrite configuration files that you have not modified.
# * --force-confnew: always install the new version of the configuration
#   file, the current version is kept in a file with the .dpkg-old suffix.
# * --force-confdef: ask dpkg to decide alone when it can and prompt
#   otherwise. This is the default behavior of dpkg and this option is
#   mainly useful in combination with --force-confold.
# * --force-confmiss: ask dpkg to install the configuration file if it’s
#   currently missing (for example because you have removed the file by
#   mistake).

sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --assume-yes update
echo

sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --assume-yes install aptitude
echo

sudo aptitude -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --assume-yes safe-upgrade
echo

sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --assume-yes autoremove
echo
