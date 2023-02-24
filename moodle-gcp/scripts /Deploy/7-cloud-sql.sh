#########################################################
# CLOUD SQL - MYSQL MANAGED
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "-----------------------------------"
echo "Criando a instância gerenciada sql."
echo "-----------------------------------"
gcloud sql instances create $MYSQL_INSTANCE_NAME \
  --database-version=MYSQL_8_0 \
  --cpu 1 \
  --memory 3840MB \
  --zone $ZONE \
  --network=$VPC_NAME \
  --retained-backups-count=7 \
  --enable-bin-log \
  --retained-transaction-log-days=7 \
  --maintenance-release-channel=production \
  --maintenance-window-day=SUN \
  --maintenance-window-hour=08 \
  --availability-type=zonal \
  --storage-type=SSD \
  --storage-auto-increase \
  --storage-size=10GB \
  --retained-backups-count=7 \
  --backup-start-time=03:00 \
  --database-flags=character_set_server=utf8,default_time_zone=-03:00 \
  --root-password=$MYSQL_ROOT_PASSWORD
  
echo "-----------------------------"  
echo "Criando o database do moodle."
echo "-----------------------------"
  gcloud sql databases create $MYSQL_DB \
  --instance $MYSQL_INSTANCE_NAME \
  --charset $MYSQL_MOODLE_DB_CHARSET \
  --collation $MYSQL_MOODLE_DB_COLLATION
  
  
