#########################################################
# Deploying NameSpace (NS)
#########################################################
source /deploy/moodle-on-gcp/0-infra/envs.sh

echo "Connect to GKE cluster via command line and update local cluster credentials."
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
    
kubectl apply -f /deploy/moodle-on-gcp/2-namespace/namespace-moodle.yaml    

echo "Press CTRL+C to exit..."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/deploying-namespace.md'>Documentation</a>"
kubectl get ns -w


