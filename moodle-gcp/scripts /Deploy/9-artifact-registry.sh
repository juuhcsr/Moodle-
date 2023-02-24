#########################################################
# Artifact Registry and Moodle Image
#########################################################
x1
echo "------------------------------------------"
echo "Criando o repositório do artifact registry"
echo "------------------------------------------"
gcloud artifacts repositories create moodle-filestore \
  --location=$REGION \
  --repository-format=docker
 
echo "-----------------------------"
echo "Criando o arquivo cloud build"
echo "-----------------------------"
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
echo "--------------------"
echo "executando o arquivo"
echo "--------------------"
cd ./deploy/moodle-on-gcp/4-moodle-image-builder/

gcloud builds submit --region $REGION
