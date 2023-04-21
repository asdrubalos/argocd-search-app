#!/bin/bash
q="$1"

# GCP Secret Manager | Settings
export GCP_PROJECT="GCP_PROJECT_ID"

# GCP Secret Manger | Name of secrets
export SECRET_ARGOCD_SERVER="SECRET_NAME_ARGOCD_SERVER"
export SECRET_ARGOCD_USER="SECRET_NAME_ARGOCD_USER"
export SECRET_ARGOCD_PASSWORD="SECRET_NAME_ARGOCD_PASSWORD"

# Getting secrets values of GCP Secret Manager
export ARGOCD_SERVER=$(gcloud secrets versions access latest --secret="${SECRET_ARGOCD_SERVER}" --project "${GCP_PROJECT}")
export ARGOCD_USER=$(gcloud secrets versions access latest --secret="${SECRET_ARGOCD_USER}" --project "${GCP_PROJECT}")
export ARGOCD_PASSWORD=$(gcloud secrets versions access latest --secret="${SECRET_ARGOCD_PASSWORD}" --project "${GCP_PROJECT}")

argocd login ${ARGOCD_SERVER} --username ${ARGOCD_USER} --password ${ARGOCD_PASSWORD} --grpc-web > /dev/null 2>&1

# Search for applications in argocd
argocd app list --grpc-web | awk '{print $1,$6}' | grep "$q" | awk '{ print ( $2 == "Healthy" )? "💚" : "💔",$1 }'

# To search using fzf tool and interactive mode
# ./argocd-search-app.sh demo | fzf -0 