# Add to Keychain
#
#   security add-generic-password -a GITHUB_API_TOKEN -s "GITHUB_API_TOKEN" -T /usr/bin/security
#
# then open Keychain and edit the item to add the password

# TODO: use iCloud Keychain that syncs?

function password-from-keychain() {
    security 2>&1 >/dev/null find-generic-password -ga $1 \
    | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

export HOMEBREW_GITHUB_API_TOKEN=`password-from-keychain GITHUB_API_TOKEN`
export CHANGELOG_GITHUB_TOKEN=`password-from-keychain GITHUB_API_TOKEN`
