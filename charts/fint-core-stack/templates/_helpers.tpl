{{/*
Calulate memory limits from xmx value for Consumer
*/}}
{{- define "fint-core-stack.consumer.xmx" }}
{{- round (div (mul (add .Values.consumer.deployment.java.xmx 256) 10) 9) 0 }}
{{- end }}

{{/*
Calulate memory limits from xmx value for Provider
*/}}
{{- define "fint-core-stack.provider.xmx" }}
{{- round (div (mul (add .Values.provider.deployment.java.xmx 256) 10) 9) 0 }}
{{- end }}

{{/*
Creates defaultBaseUrl based on environment
*/}}
{{- define "fint-core-stack.defaultBaseUrl" }}
{{- required "Deployment environment is missing!" .Values.environment }}
{{- if eq .Values.environment "pwf" }}
{{- printf "https://play-with-fint.felleskomponent.no" | quote }}
{{- else }}
{{- printf "https://%s.felleskomponent.no" .Values.environment | quote}}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "fint-core-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fint-core-stack.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fint-core-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fint-core-stack.labels" -}}
helm.sh/chart: {{ include "fint-core-stack.chart" . }}
{{ include "fint-core-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fint-core-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fint-core-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
