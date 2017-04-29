#!/bin/sh

if [ -f vault.key ] ; then
  exec ansible-playbook -i hosts-vultr --vault-password-file=vault.key "$@"
else
  exec ansible-playbook -i hosts-vultr --ask-vault-password "$@"
fi
