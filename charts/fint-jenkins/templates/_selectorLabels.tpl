{{- define "lib-chart.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "fint-library.name" . }}
{{- end }}