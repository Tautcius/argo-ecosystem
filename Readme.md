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

To trigger demo webhook run:

```zsh
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:8445/example
```

To trigger build pipeline need to post with curl:

```zsh
curl -d '{"tag":"0.1.7"}' -H "Content-Type: application/json" -X POST http://localhost:8445/commit
```

To trigger tests workload:

```zsh
curl -d '{"message":"this is mock for running test"}' -H "Content-Type: application/json" -X POST http://localhost:8445/tests
```

```zsh
curl -d '{"message":"this is mock for running test"}' -H "Content-Type: application/json" -X POST http://webhook-eventsource.argo.svc.cluster.local/tests
```
