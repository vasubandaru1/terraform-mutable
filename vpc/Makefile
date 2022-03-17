help:


clean: ## clean the meta data
	@rm -rf .terraform

dev-apply:clean ## make Dev environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -var-file=env/dev.tf -auto-approve



prod-apply: clean ## make prod environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -var-file=env/prod.tf -auto-approve


dev-destroy:clean ## make destroy environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -var-file=env/dev.tf -auto-approve


prod-destroy:clean ## make destroy environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -var-file=env/dev.tf -auto-approve