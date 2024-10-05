.DEFAULT_GOAL := init
KUBE_CONTEXT := k3d-k3s-default

.PHONY: apply-dev
apply-dev:
	kustomize build ./vault/dev --enable-helm | kubectl apply --context=$(KUBE_CONTEXT) -f -
	kustomize build ./argo-cd/dev --enable-helm | kubectl apply --context=$(KUBE_CONTEXT) -f -

TOOLS := pre-commit:brew
init: install-tools pre-commit-install

install-tools:
	@echo "Installing tools..."
	@$(foreach tool,$(TOOLS),$(call install_if_missing,$(word 1,$(subst :, ,$(tool))),$(word 2,$(subst :, ,$(tool))));)

pre-commit-install:
	@echo "Installing pre-commit..."
	@pre-commit install
	@pre-commit install --hook-type commit-msg

install_if_missing = \
 if ! command -v $(1) &> /dev/null; then \
  echo "Installing $(1) with $(2)..."; \
  if [ "$(2)" = "brew" ]; then \
    brew install $(1); \
  elif [ "$(2)" = "pip" ]; then \
    pip install $(1); \
  fi; \
 fi
