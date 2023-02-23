#########################################################
# Artifact Registry and Moodle Image
#########################################################
x1

echo "Cria o repositório do artifact registry"
gcloud artifacts repositories create moodle-filestore \
  --location=$REGION \
  --repository-format=docker
 

echo "Criando o arquivo cloud build"

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

echo "executando o arquivo"

cd ./deploy/moodle-on-gcp/4-moodle-image-builder/

gcloud builds submit --region $REGION
