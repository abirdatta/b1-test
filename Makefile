TERRAFORM	:= /usr/bin/terraform

###
.PHONY: terraform-install
terraform-install: terraform
	sudo mv $< /usr/bin/terraform

terraform: terraform.zip
	unzip $<

# https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
terraform.zip:
	curl -L "https://releases.hashicorp.com/terraform/$(TF_VERSION)/terraform_$(TF_VERSION)_$(TF_OS)_$(TF_ARCH).zip" -o $@

# check for environment variables required by terraform
.PHONY: terraform-init-check
terraform-init-check:
ifndef AWS_ACCESS_KEY_ID
	$(error AWS_ACCESS_KEY_ID is undefined)
endif
ifndef AWS_SECRET_ACCESS_KEY
	$(error AWS_SECRET_ACCESS_KEY is undefined)
endif
ifndef APP_TAG
	$(error APP_TAG is undefined)
endif

.PHONY: terraform-setup
terraform-setup: terraform-init-check
	sed -i -e "s/SED_IMAGE_VERSION/${APP_TAG}/g" *.tf && \
	$(TERRAFORM) workspace new dev && \
    $(TERRAFORM) workspace select dev

.PHONY: terraform-workspace
terraform-workspace:
	$(TERRAFORM) init -input=false

.PHONY: terraform-init
terraform-init: terraform-setup
	$(TERRAFORM) init -input=false

.PHONY: terraform-plan
terraform-plan: terraform-init
	$(TERRAFORM) plan -input=false

.PHONY: terraform-apply
terraform-apply: terraform-plan
	$(TERRAFORM) apply -input=false -auto-approve

.PHONY: terraform-plan-destroy
terraform-plan-destroy: terraform-init
	$(TERRAFORM) plan -destroy -input=false

.PHONY: terraform-destroy
terraform-destroy: terraform-plan-destroy
	$(TERRAFORM) destroy -input=false -auto-approve