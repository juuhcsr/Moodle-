#########################################################
# Deploying Persistent Volume (PV)
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

echo "Connect to GKE cluster via command line and update local cluster credentials."
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
    
    
nano ./deploy/moodle-on-gcp/1-pv/pv-filestore.yaml

kubectl apply -f ./deploy/moodle-on-gcp/1-pv/pv-filestore.yaml