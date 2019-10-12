copy_file:
	@ansible-playbook -i hosts -u demo --private-key=./keys/id_rsa ./ansible/copy-file.yml
