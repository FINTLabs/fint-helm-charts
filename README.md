# FINT Helm Charts

## Dry-run a chart
`helm install --debug --dry-run <name of install app> <name of chart>`

## Dry-run a specific version of a adapter
`helm install --debug --dry-run <name of install app> -f <name of value file> <name of chart>`

### Example from fint-helm-charts/charts/fint-adapter-sikri
`helm install --debug --dry-run fint-adapter-sikri -f values-viken.yaml ../fint-adapter-sikri/`

### Example from local file system
`helm install --debug --dry-run profilbilde ./fint-profilbilde-core`