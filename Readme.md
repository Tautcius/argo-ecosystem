# Setup for Argo ecosystem

This setup includes:
    - Argo CD
    - Argo Events
    - Argo Rollouts
    - Argo Workflows

## Intstalation

Create cluster with:

```zsh
make kind
```

Install all apps with:

```zsh
make argo-all
```

### Login info

User: admin
Pass: admin

## Clean up

To destroy everything use:

```zsh
make kind-delete
```

## webhook event

to trigger build pipeline need to post with curl

```zsh
curl -d '{"tag":"0.1.5"}' -H "Content-Type: application/json" -X POST http://localhost:8445/commit
```
