help:


clean: ## clean the meta data
	@rm -rf .terraform

dev-apply:clean ## make Dev environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -auto-approve -var-file=env/dev.tf



prod-apply: clean ## make prod environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -auto-approve -var-file=env/prod.tf


dev-destroy:clean ## make destroy environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/dev.tf


prod-destroy:clean ## make destroy environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/dev.tf