{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nestjs-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nestjs-app.fullname" -}}
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
{{- define "nestjs-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nestjs-app.labels" -}}
helm.sh/chart: {{ include "nestjs-app.chart" . }}
{{ include "nestjs-app.selectorLabels" . }}
app.kubernetes.io/part-of: {{ include "nestjs-app.name" . }}
app.kubernetes.io/component: "backend"  # Customize as needed
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nestjs-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nestjs-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nestjs-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nestjs-app.fullname" .) .Values.serviceAccount.name | quote }}
{{- else }}
{{- default "default" .Values.serviceAccount.name | quote }}
{{- end }}
{{- end }}

{{/*
Create MongoDB service name.
*/}}
{{- define "nestjs-app.mongodb-service" -}}
{{- printf "%s-mongodb-service" (include "nestjs-app.fullname" .) -}}
{{- end }}