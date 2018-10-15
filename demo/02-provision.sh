#!/usr/bin/env bash

cd ../ansible

time export ANSIBLE_TF_DIR=../terraform/digitalocean && ansible-playbook --vault-id ~/.ansible_vault_pass.txt -i /etc/ansible/terraform.py sos.yml -e "target_env=staging rev=`git log -1 --pretty='%h'` security_mode=secure"

cd -