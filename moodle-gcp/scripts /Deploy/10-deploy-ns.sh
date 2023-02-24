#########################################################
# Deploying NameSpace (NS)
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "-----------------------------------------------------------------------------------"
echo "Conectando ao Cluster do kubernetes via linha de comando e atualizando credênciais."
echo "-----------------------------------------------------------------------------------"
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
    
kubectl apply -f ./deploy/moodle-on-gcp/2-namespace/namespace-moodle.yaml    

echo "Pressione CTRL+C para sair..."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/deploying-namespace.md'>Documentação</a>"

kubectl get ns -w


