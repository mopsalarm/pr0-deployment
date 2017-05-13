#!/bin/sh

if [ -f vault.key ] ; then
  exec ./ansiblew -i inventories/vultr.yaml --vault-password-file=vault.key "$@"
else
  exec ./ansiblew -i inventories/vultr.yaml --ask-vault-pass "$@"
fi
