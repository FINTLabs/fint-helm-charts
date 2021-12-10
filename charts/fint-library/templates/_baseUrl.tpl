{{/*
Creates defaultBaseUrl based on environment
*/}}
{{- define "fint-library.defaultBaseUrl" -}}
{{- if eq .Values.environment "pwf" }}
{{- printf "https://play-with-fint.felleskomponent.no" | quote }}
{{- else }}
{{- printf "https://%s.felleskomponent.no" .Values.environment | quote}}
{{- end }}
{{- end }}
