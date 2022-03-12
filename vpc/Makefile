help:

clean:
	@rm -rf .terraform

dev-apply:clean ## Create Dev Environment
	     @terraform init -backend-config=env/dev-backend.tfvars
	     @terraform apply -auto-approve -var-file=env/dev.tfvars

prod-apply:clean ## Create prod Environment
	     @terraform init -backend-config=env/prod-backend.tfvars
	     @terraform apply -auto-approve -var-file=env/prod.tfvars


dev-destroy:clean ## destroy Dev Environment
	     @terraform init -backend-config=env/dev-backend.tfvars
	     @terraform destroy -auto-approve -var-file=env/dev.tfvars

prod-destroy:clean ## destroy prod Environment
	     @terraform init -backend-config=env/prod-backend.tfvars
	     @terraform destroy -auto-approve -var-file=env/prod.tfvars
