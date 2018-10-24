#!/usr/bin/env bash

cd ../ansible

export ANSIBLE_TF_DIR=../terraform/digitalocean && time ansible-playbook -i /etc/ansible/terraform.py restore.yml -e "target_env=staging"

cd -
