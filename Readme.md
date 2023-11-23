# Setup for Argo ecosystem

This setup includes:
    - Argo CD
    - Argo Events
    - Argo Rollouts
    - Argo Workflows

## Intstalation

```zsh
kind create cluster --wait 120s --config=infra/cluster.yaml
```

## Install cert-manager

```zsh
helm install cert-manager cert-manager \
  --repo https://charts.jetstack.io \
  --version 1.11.5 \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  --wait

```

## Install ArgoCD

```zsh
helm install argocd argo-cd \
  --repo https://argoproj.github.io/argo-helm \
  --version 5.46.6 \
  --namespace argocd \
  --create-namespace \
  --set 'configs.secret.argocdServerAdminPassword=$2a$10$V.Z2TW0MXeErKz9bZx70OOqqjbeJbpQ1njW9hOkwblnMSLC1ENKMi' \
  --set dex.enabled=false \
  --set notifications.enabled=false \
  --set server.service.type=NodePort \
  --set server.service.nodePortHttp=31443 \
  --wait
```

### Login info

User: admin
Pass: testKargoPass
