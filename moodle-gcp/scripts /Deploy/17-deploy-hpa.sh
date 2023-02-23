#########################################################
# Enabling horizontal scale for Pods
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

echo "Conectando ao cluster e obtendo credências."
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
    
kubectl apply -f ./deploy/moodle-on-gcp/9-hpa/moodle-hpa.yaml  

echo "Pressione CTRL+C para sair..."
echo "Make sure the HPA configuration was successfully applied."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/enabling-hpa.md'>Documentation</a>"
kubectl get hpa -n moodle -w
