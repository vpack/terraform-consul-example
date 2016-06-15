.PHONY: plan apply modules setup

AZ_PATH = `find . -type f -name 'getvariables.rb' -exec dirname {} \; | tail -n 1`

default: setup

setup: 
	terraform get
	ruby "${AZ_PATH}/getvariables.rb"
	mv variables.tf.json "${AZ_PATH}/variables.tf.json"

apply: 
	terraform apply

reapply: 
	terraform destroy -force
	terraform apply
plan: 
	terraform plan

again:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user=ec2-user -i "10.120.106.49," ansible/playbook.yml
