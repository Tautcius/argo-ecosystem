.PHONY: test

test:
	@echo "Running tests..."

.PHONY: kind

kind: 
	@echo "Creating kind cluster..."
	kind create cluster --wait 120s --config=infra/cluster.yaml
	@echo "Kind cluster created"

.PHONY: kind-delete

kind-delete:
	@echo "Deleting kind cluster..."
	kind delete clusters argo
	@echo "Kind cluster deleted"

.PHONY: cert-manager

cert-manager:
	@echo "Installing cert-manager..."
	helm install cert-manager cert-manager \
	--repo https://charts.jetstack.io \
	--version 1.13.2 \
	--namespace cert-manager \
	--create-namespace \
	--set installCRDs=true \
	--wait
	@echo "Cert-manager installed"

.PHONY: argo-cd

argo-cd:	
	@echo "Installing argo-cd..."
	helm upgrade -i argocd argo-cd \
	--repo https://argoproj.github.io/argo-helm \
	--version 5.51.4 \
	--namespace argocd \
	--create-namespace \
	--values argo/cd/values.yaml \
	--wait
	@echo "Argo-cd installed"

.PHONY: argo-events

argo-events:
	@echo "Installing argo-events..."
	helm upgrade -i argo-events argo-events \
	--repo https://argoproj.github.io/argo-helm \
	--version 3.1.0 \
	--namespace argo-events \
	--create-namespace \
	--set installCRDs=true \
	--set controller.service.type=NodePort \
	--set controller.service.nodePortHttp=31444 \
	--set sensor.service.type=NodePort \
	--set sensor.service.nodePortHttp=31445 \
	--wait
	@echo "Argo-events installed"

.PHONY: argo-workflows

argo-workflows:
	@echo "Installing argo-workflows..."
	helm upgrade -i argo-workflows argo-workflows \
	--repo https://argoproj.github.io/argo-helm \
	--version 0.39.3 \
	--namespace argo \
	--create-namespace \
	--values argo/workflows/values.yaml \
	--wait
	@echo "Argo-workflows installed"

.PHONY: argo-rollouts

argo-rollouts:
	@echo "Installing argo-rollouts..."
	helm install argo-rollouts argo-rollouts \
	--repo https://argoproj.github.io/argo-helm \
	--version 1.1.0 \
	--namespace argo-rollouts \
	--create-namespace \
	--set installCRDs=true \
	--set controller.service.type=NodePort \
	--set controller.service.nodePortHttp=31447 \
	--wait
	@echo "Argo-rollouts installed"

PHONY: argo-all

argo-all: argo-cd argo-workflows argo-rollouts argo-events