#!/bin/sh

if [ -f vault.key ] ; then
  exec ansible-playbook -i hosts --vault-password-file=vault.key "$@"
else
  exec ansible-playbook -i hosts --ask-vault-password "$@"
fi
