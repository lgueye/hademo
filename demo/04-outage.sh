#!/usr/bin/env bash

cd ../ansible

time export ANSIBLE_TF_DIR=../terraform/digitalocean && ansible-playbook -i /etc/ansible/terraform.py outage.yml -e "target_env=staging"

cd -
