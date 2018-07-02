# Usable Apps Inc.
# Ugochukwu Enyioha

SHELL := /bin/bash -O extglob -c

export TF_IN_AUTOMATION = 1

init:
	pushd infra && terraform init -backend-config=../backend.tfvars && popd
	pushd helm && terraform init -backend-config=../backend.tfvars && popd

deploy:
	pushd infra && terraform apply -var-file=../auth.tfvars -var-file=../backend.tfvars && popd
	kubectl config delete-context jenkins || true
	az aks get-credentials --resource-group jenkins_helm --name jenkins
	helm init
	sleep 20
	pushd helm && terraform apply -var-file=../auth.tfvars -var-file=../backend.tfvars && popd
	kubectl create clusterrolebinding jenkins-project --clusterrole=cluster-admin --serviceaccount=jenkins-project:jenkins

destroy:
	pushd helm && terraform destroy -var-file=../backend.tfvars -var-file=../auth.tfvars && popd
	pushd infra && terraform destroy -var-file=../backend.tfvars -var-file=../auth.tfvars && popd
	kubectl delete clusterrolebinding jenkins-project || true
	kubectl config delete-context jenkins || true