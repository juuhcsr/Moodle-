#########################################################
# Deploying Persistent Volume Claim (PVC)
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

echo "-----------------------------------------------------------------------------------"
echo "Conectando ao Cluster do kubernetes via linha de comando e atualizando credênciais."
echo "-----------------------------------------------------------------------------------"
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
echo "--------------------"
echo "executando o arquivo"
echo "--------------------"
kubectl apply -f ./deploy/moodle-on-gcp/3-pvc/pvc-filestore.yaml    

echo "Pressione CTRL+C para sair..."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/deploying-persistent-volume-claim.md'>Documentation</a>"
kubectl get pvc -n moodle -w
