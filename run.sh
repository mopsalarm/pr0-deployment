#!/bin/sh

exec ansible-playbook -i hosts --ask-vault-pass -e @secrets.yaml "$@"
