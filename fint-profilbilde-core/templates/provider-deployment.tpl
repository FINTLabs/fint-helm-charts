apiVersion: apps/v1
kind: Deployment
metadata:
  labels: {fint.stack: profilbilde, fint.role: provider}
  name: provider-profilbilde
spec:
  replicas: 1
  selector:
    matchLabels: {fint.stack: profilbilde, fint.role: provider}
  strategy:
    type: RollingUpdate
    rollingUpdate: {maxSurge: 1, maxUnavailable: 0}
  template:
    metadata:
      labels: {fint.stack: profilbilde, fint.role: provider}
    spec:
      containers:
        - envFrom:
          - configMapRef:
              name: fint-environment
          - secretRef:
              name: fint-events-azure-eventhub
          env:
            - {name: TZ, value: Europe/Oslo}
            - {name: JAVA_TOOL_OPTIONS, value: '-XX:+ExitOnOutOfMemoryError -Xmx2G -verbose:gc'}
            - {name: fint.audit.mongo.databasename, value: fint-audit-beta}
            - name: fint.audit.mongo.connection-string
              valueFrom:
                secretKeyRef: {key: mongodb, name: fint-audit}
            - {name: fint.audit.mongo.collection, value: auditEvents}
            - {name: fint.events.orgIds, value: health.fintlabs.no}
            - {name: fint.hazelcast.kubernetes.enabled, value: 'true'}
            - {name: fint.hazelcast.kubernetes.namespace, value: default}
            - {name: fint.hazelcast.kubernetes.labelName, value: fint.stack}
            - {name: fint.hazelcast.kubernetes.labelValue, value: profilbilde}
            - {name: fint.provider.max-number-of-emitters, value: '5'}
            - {name: server.context-path, value: /profilbilde/provider}
            - {name: fint.provider.assets.endpoint, value: 'https://admin.fintlabs.no/api/components/assets/profilbilde'}
            - {name: logging.level.no.fint.audit.plugin.eventhub, value: debug}
          image: "{{ .Values.provider.image.repository }}:{{ .Values.provider.image.tag }}"
          imagePullPolicy: "{{ .Values.provider.image.pullPolicy }}"
          name: provider-profilbilde
          ports:
            - {containerPort: 8080}
          readinessProbe:
            httpGet: {path: /profilbilde/provider/health, port: 8080}
            initialDelaySeconds: 60
            timeoutSeconds: 5
          resources:
            limits: {memory: 3Gi, cpu: '2'}
            requests: {memory: 2Gi, cpu: 250m}
      restartPolicy: Always