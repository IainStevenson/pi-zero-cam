#!/bin/bash
ansible-playbook -i inventory.ini system-playbook.yml
ansible-playbook -i inventory.ini camera-playbook.yml
