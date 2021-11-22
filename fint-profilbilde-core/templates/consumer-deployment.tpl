apiVersion: apps/v1
kind: Deployment
metadata:
  labels: {fint.stack: profilbilde, fint.role: consumer}
  name: consumer-profilbilde
spec:
  replicas: 1
  selector:
    matchLabels: {fint.stack: profilbilde, fint.role: consumer}
  strategy:
    type: RollingUpdate
    rollingUpdate: {maxSurge: 1, maxUnavailable: 0}
  template:
    metadata:
      labels: {fint.stack: profilbilde, fint.role: consumer}
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
            - {name: fint.cache.manager, value: default}
            - {name: fint.events.orgIds, value: health.fintlabs.no}
            - {name: fint.consumer.default-org-id, value: fintlabs.no}
            - {name: fint.consumer.override-org-id, value: 'true'}
            - {name: fint.hazelcast.kubernetes.enabled, value: 'true'}
            - {name: fint.hazelcast.kubernetes.namespace, value: default}
            - {name: fint.hazelcast.kubernetes.labelName, value: fint.stack}
            - {name: fint.hazelcast.kubernetes.labelValue, value: profilbilde}
            - {name: fint.relations.default-base-url, value: 'https://beta1.felleskomponent.no'}
            - {name: server.context-path, value: /profilbilde}
            - {name: logging.level.no.fint.consumer.thumbor, value: DEBUG}
            - {name: logging.level.no.fint.audit.plugin.eventhub, value: debug}
          image: "{{ .Values.consumer.image.repository }}:{{ .Values.consumer.image.tag }}"
          imagePullPolicy: "{{ .Values.consumer.image.pullPolicy }}"
          name: consumer-profilbilde
          ports:
            - {containerPort: 8080}
          readinessProbe:
            httpGet: {path: /profilbilde/health, port: 8080}
            initialDelaySeconds: 30
            timeoutSeconds: 5
          resources:
            limits: {memory: 3Gi, cpu: '2'}
            requests: {memory: 2Gi, cpu: 250m}
      restartPolicy: Always