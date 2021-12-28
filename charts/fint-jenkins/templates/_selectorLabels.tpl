{{- define "fint-jenkins.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "fint-jenkins.name" . }}
{{- end }}