#########################################################
# INITIAL SETUP
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

gcloud config set project $PROJECT_ID
gcloud services enable \
    cloudbuild.googleapis.com \
    compute.googleapis.com \
    artifactregistry.googleapis.com \
    sql-component.googleapis.com \
    sqladmin.googleapis.com \
    file.googleapis.com \
    recaptchaenterprise.googleapis.com


