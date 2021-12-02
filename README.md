# FINT Helm Charts

Here you can find the sources for FINTs Helm Charts. 


## Dry-run a specific version of a adapter
`helm install --debug --dry-run <name of install app> -f <name of value file> <name of chart>`

### Example from fint-helm-charts/charts/fint-adapter-sikri
`helm install --debug --dry-run fint-adapter-sikri -f values-viken.yaml ../fint-adapter-sikri/`

### Example from local file system
`helm install --debug --dry-run profilbilde ./fint-profilbilde-core`

### Example from fint-helm-charts/charts/fint-adapter-sikri for dry-run specific adapter, that includes op-time, and where you need to define which environment to deploy.
`helm install --debug --dry-run fint-adapter-sikri -f values-vlfk.yaml ../fint-adapter-sikri/ --set environment=beta`

You can find the Helm Chart repository [here](https://fintlabs.github.io/helm-charts/).


[Internal guidlines of how to write Helm Charts (publicly available)](https://fintlabs.atlassian.net/wiki/external/415858689/ZmEyMDQ3ZjQ5OGEzNGVjM2I2ZTkyMjg1NTAwNjA1YmU?atlOrigin=eyJpIjoiMThhZWYzNTUwNGFmNDc4ZmE1NjM4YTE3YWNjNzJmMzciLCJwIjoiYyJ9)


