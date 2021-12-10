{{/*
Expand the name of the chart.
*/}}
{{- define "fint-sikri-arkiv-adapter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fint-sikri-arkiv-adapter.fullname" -}}
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
{{- define "fint-sikri-arkiv-adapter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fint-sikri-arkiv-adapter.labels" -}}
helm.sh/chart: {{ include "fint-sikri-arkiv-adapter.chart" . }}
{{ include "fint-sikri-arkiv-adapter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fint-sikri-arkiv-adapter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fint-sikri-arkiv-adapter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fint-sikri-arkiv-adapter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fint-sikri-arkiv-adapter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Creates defaultBaseUrl based on environment
*/}}
{{- define "fint-core-stack.defaultBaseUrl" -}}
{{- if eq .Values.environment "pwf" }}
{{- printf "https://play-with-fint.felleskomponent.no" | quote }}
{{- else }}
{{- printf "https://%s.felleskomponent.no" .Values.environment | quote}}
{{- end }}
{{- end }}

