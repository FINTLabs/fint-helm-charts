{{- define "lib-chart.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}