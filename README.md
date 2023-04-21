# argocd-search-apps
This script allows listing the applications in argocd indicating their Healthy/Unhealthy status with a heart emoji (green or red).

## Requirements

- ```argocd``` CLI:
It will be necessary to list the applications to search.
Check the following link if you don't have it installed https://argo-cd.readthedocs.io/en/stable/cli_installation/

- ```gcloud``` CLI:
It will be necessary to consult the credentials of argocd in a secure way stored in GCP Secret Manager. 
Check the following link if you do not have it installed https://cloud.google.com/sdk/docs/install?hl=es-419

- ```fzf```: It's an interactive Unix filter for command-line that can be used with any list. 
See the following link if you don't have it installed https://github.com/junegunn/fzf

- ```GCP Secret Manger```: 
You will need to have a GCP project with 3 variables stored in secret manager corresponding to the argocd credentials

## Settings
Edit the file ```argocd-search-app.sh``` and change environment variables

```bash
# GCP Secret Manger | Name of secrets
export SECRET_ARGOCD_SERVER="SECRET_NAME_ARGOCD_SERVER"
export SECRET_ARGOCD_USER="SECRET_NAME_ARGOCD_USER"
export SECRET_ARGOCD_PASSWORD="SECRET_NAME_ARGOCD_PASSWORD"
```

## Usage

- List all existing Healthy/Unhealthy apps

```bash
./argocd-search-app.sh

💔 app-1
💚 app-2
💚 app-3
💚 demo-1
💔 demo-2
💚 demo-3
💚 demo-4
💚 demo-5

```

- List only existing Healthy/Unhealthy apps with a filter by name. The following command will display only applications that have the word "demo" as part of the name.

```bash
./argocd-search-app.sh demo

💚 demo-1
💔 demo-2
💚 demo-3
💚 demo-4
💚 demo-5

```
- To navigate through the list as an interactive menu we will use the tools ```fzf```.
you can use the up, down, mouse pointer and scroll keys to navigate between the list

```bash
./argocd-search-app.sh demo | fzf -0

  💚 demo-1
  💔 demo-2
  💚 demo-3
  💚 demo-4
> 💚 demo-5
  5/5 ------------------------
> _
```