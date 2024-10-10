create-vault-root-token-secret:
	@read -p "Enter Vault root token: " rootToken; \
	kubectl -n vault create secret generic vault-root-token-secret \
		--from-literal=root-token=$$rootToken \
		--dry-run=client -o yaml | kubectl apply -f -
