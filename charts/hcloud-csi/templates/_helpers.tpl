{{/*
Expand the name of the chart.
*/}}
{{- define "hcloud-csi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hcloud-csi.fullname" -}}
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
{{- define "hcloud-csi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hcloud-csi.labels" -}}
helm.sh/chart: {{ include "hcloud-csi.chart" . }}
{{ include "hcloud-csi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hcloud-csi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hcloud-csi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hcloud-csi.serviceAccountName" -}}
{{- default (include "hcloud-csi.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the storage class to use
*/}}
{{- define "hcloud-csi.storageClassName" -}}
{{- default (include "hcloud-csi.fullname" .) .Values.storageClass.name }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "hcloud-csi.secretName" -}}
{{- if .Values.secret.create }}
{{- default (include "hcloud-csi.fullname" .) .Values.secret.name }}
{{- else }}
{{- default "default" .Values.secret.name }}
{{- end }}
{{- end }}
