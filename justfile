play:
  ansible-playbook ansible/playbooks/wireguard.yaml -i ansible/hosts.yaml

deps:
  ansible-galaxy collection install ansible.posix
  ansible-galaxy collection install community.general

init:
  cd terraform; terraform init

apply:
  just init
  cd terraform; terraform apply -var-file auto.tfvars

output:
  just init
  cd terraform; terraform output

destroy:
  just init
  cd terraform; terraform destroy -var-file auto.tfvars