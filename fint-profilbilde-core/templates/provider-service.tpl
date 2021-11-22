apiVersion: v1
kind: Service
metadata:
  annotations: {service.beta.kubernetes.io/azure-load-balancer-internal: 'true'}
  labels: {fint.stack: profilbilde, fint.role: provider}
  name: provider-profilbilde
spec:
  type: LoadBalancer
  ports:
    - {name: '8080', port: 8080}
  selector: {fint.stack: profilbilde, fint.role: provider}