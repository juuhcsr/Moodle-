#########################################################
# FILESTORE - NFS 2.5Tb
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "--------------------------------"
echo "Criando o Serviço do Filestore ."
echo "--------------------------------"
gcloud filestore instances create $FILESTORE_NAME \
  --description="NFS to support Moodle data." \
  --tier=BASIC_SSD \
  --file-share="name=moodleshare,capacity=2.5TB" \
  --network="name=$VPC_NAME,reserved-ip-range=moodle-managed-range-filestore,connect-mode=PRIVATE_SERVICE_ACCESS" \
  --zone=$ZONE
