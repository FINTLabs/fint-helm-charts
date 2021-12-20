# reposilite

How to install reposilite

### Example
`helm install fint-kundeportal -./fint-kundeportal/`

If the secret fint-portal-user already exist, run helm install/upgrade without onepassword-item. 
e.g. set onePasswordItem.create to false:

```
onePasswordItem: 
  name: fint-portal-user
  create: false
```

link: 