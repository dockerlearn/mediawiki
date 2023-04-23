{{- define "commonchart.envname" -}}
  {{- $envtype := required "A valid envtype value is required" .Values.global.envtype -}}
  {{- $envid := required "A valid envid value is required" .Values.global.envid -}}
  {{- printf "%s%s" $envtype $envid -}}
{{- end -}}

{{- define "commonchart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "commonchart.fullname" -}}
{{ $envname :=  (include "commonchart.envname" . ) -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Values.global.appName .Values.nameOverride -}}
{{- printf "%s-%s" $name $envname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

