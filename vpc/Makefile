help:

dev-apply: ## Create Dev Environment
	     @terraform init -backend-config=env/dev-backend.tfvars
	     @terraform apply -auto-approve -var-file=env/dev-backend.tfvars


prod-apply: ## Create prod Environment
	     @terraform init -backend-config=env/prod-backend.tfvars
	     @terraform apply -auto-approve -var-file=env/prod-backend.tfvars


dev-destroy: ## destroy Dev Environment
	     @terraform init -backend-config=env/dev-backend.tfvars
	     @terraform destroy -auto-approve -var-file=env/dev-backend.tfvars

prod-destroy: ## destroy prod Environment
	     @terraform init -backend-config=env/prod-backend.tfvars
	     @terraform destroy -auto-approve -var-file=env/prod-backend.tfvars
