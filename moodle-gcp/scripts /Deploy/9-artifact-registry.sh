#########################################################
# Artifact Registry and Moodle Image
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

#echo "Creates an Artifact Registry repo for building Moodle images"
#gcloud artifacts repositories create moodle-filestore \
#  --location=$REGION \
#  --repository-format=docker
 

echo "Creating cloudbuild.yaml file"

mv ./deploy/moodle-on-gcp/4-moodle-image-builder/cloudbuild.yaml ./deploy/moodle-on-gcp/4-moodle-image-builder/cloudbuild_bkp.yaml

BUILD_TAG='$BUILD_ID'

cat <<EOF >  ./deploy/moodle-on-gcp/4-moodle-image-builder/cloudbuild.yaml


steps:
- name: 'gcr.io/cloud-builders/docker'
  args: ['build','-t', '$REGION-docker.pkg.dev/$PROJECT_ID/moodle-filestore/moodle:$BUILD_TAG', '.']
- name: 'gcr.io/cloud-builders/docker'
  args: ['push', '$REGION-docker.pkg.dev/$PROJECT_ID/moodle-filestore/moodle:$BUILD_TAG']
EOF

cat ./deploy/moodle-on-gcp/4-moodle-image-builder/cloudbuild.yaml

cd ./deploy/moodle-on-gcp/4-moodle-image-builder/

sleep 5s

gcloud builds submit --region $REGIO
