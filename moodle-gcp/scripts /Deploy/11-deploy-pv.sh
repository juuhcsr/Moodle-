#########################################################
# Deploying Persistent Volume (PV)
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "-----------------------------------------------------------------------------------"
echo "Conectando ao Cluster do kubernetes via linha de comando e atualizando credênciais."
echo "-----------------------------------------------------------------------------------"
NFS_IP = gcloud filestore instances describe $FILESTORE_NAME  --location=$ZONE --format=get"(networks.ipAddresses[0])" 
echo $NFS_IP
sleep 10s

gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
echo "--------------------------------------------------"
echo "Coloque o ip interno do filestore na próxima etapa"
echo "--------------------------------------------------"
sleep 5s   
nano ./deploy/moodle-on-gcp/1-pv/pv-filestore.yaml
echo "--------------------"
echo "executando o arquivo"
echo "--------------------"
kubectl apply -f ./deploy/moodle-on-gcp/1-pv/pv-filestore.yaml