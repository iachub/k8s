gen-gh-clientSecret:
	@read -p "Enter GitHub client secret: " clientSecret; \
	kubectl -n argocd create secret generic github-dex-secret \
		--from-literal=dex.github.clientSecret=$$clientSecret \
		--dry-run=client -o yaml | kubectl apply -f -
	kubectl -n argocd label secret github-dex-secret app.kubernetes.io/part-of=argocd

gen-iachub-k8s-repo-secret:
	kubeseal -f iachub-k8s-repo.yaml --controller-namespace sealed-secrets --controller-name sealed-secrets -o yaml > ./base/sealed-secret-iachub-k8s-repo.yaml
