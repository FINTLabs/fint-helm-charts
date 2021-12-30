# fint-admin-portal-backend

How to install fint-admin-portal-backend

This helm chart uses helm library fint-library and therefore needs to run 
`helm dependency update fint-admin-portal-backend/`
Before installing the chart

Afther the dependency is updated you can run 
`helm install fint-admin-portal-backend ./fint-admin-portal-backend/`
