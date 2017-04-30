#!/bin/sh

if [ -f vault.key ] ; then
  exec ./ansiblew -i hosts-vultr --vault-password-file=vault.key "$@"
else
  exec ./ansiblew -i hosts-vultr --ask-vault-pass "$@"
fi
