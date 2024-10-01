.DEFAULT_GOAL := init
KUBE_CONTEXT := k3d-k3s-default

.PHONY: apply-dev
apply-dev:
	kustomize build ./argo-cd/dev --enable-helm | kubectl apply --context=$(KUBE_CONTEXT) -f -

TOOLS := pre-commit
init: pre-commit-install

install-tools:
	@echo "Installing tools..."
	@$(foreach tool,$(TOOLS),$(call install_if_missing,$(tool));)

pre-commit-install:
	@echo "Installing pre-commit..."
	@pre-commit install
	@pre-commit install --hook-type commit-msg
