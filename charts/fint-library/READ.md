# FINT Helm Library

Here you can find the working library files like service, deployment and onepasswordoperator. 


## How to use:
First create a new helm chart:

`helm create mychart`

Then add fint-library as a depencency in your newly created helm chart:

In Chart.yaml:
```
dependencies:
- name: fint-library
  version: 0.1.0
  repository: file://../fint-library
```
  
Now you have to add the template files you want to use. Go in your template/ folder and add files like deployment and service.
In these files you only need to add one line:
    - {{- include "lib-chart.service" .}}       - for service
    - {{- include "lib-chart.deployment" .}}    - for deployment

Then you can fill your values.yaml with the necessary configuration. In fint-library repo there exist a values.yaml that can be used as a guidance.
After the value have been added you can run the following command:

`helm dependency update mychart/`

After that you can install the chart 

`helm install test test --debug --dry-run`