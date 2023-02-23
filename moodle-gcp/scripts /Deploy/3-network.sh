#########################################################
# NETWORK
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh 


echo "criando o ip do load balance."
gcloud compute addresses create moodle-ingress-ip --global

echo "Habilitando criação de serviços (se não estiver habilitado)."
gcloud services enable servicenetworking.googleapis.com \
  &nbsp;--project=$PROJECT_ID

echo "Criando nova VPC."

gcloud compute networks create $VPC_NAME \
  --subnet-mode=custom \
  --bgp-routing-mode=regional \
  --mtu=1460
 
 gcloud compute networks subnets create $SUBNET_NAME \
  --project=$PROJECT_ID \
  --range=$SUBNET_RANGE \
  --stack-type=IPV4_ONLY \
  --network=$VPC_NAME \
  --region=$REGION

echo "Criando uma rede secundária pro gke."
gcloud compute networks subnets update $SUBNET_NAME \
  --region $REGION \
  --add-secondary-ranges pod-range-gke-1=$GKE_POD_RANGE;
 
echo  "Habilitando conexão do kubernetes."
 gcloud compute networks subnets update $SUBNET_NAME \
  --region $REGION \
  --add-secondary-ranges svc-range-gke-1=$GKE_SVC_RANGE;
  
 echo "Configurando Nat e Cloud router."
 gcloud compute routers create $NAT_ROUTER \
    --project=$PROJECT_ID \
    --network=$VPC_NAME \
    --asn=64512 \
    --region=$REGION
 
 gcloud compute routers nats create $NAT_CONFIG \
    --router=$NAT_ROUTER \
    --auto-allocate-nat-external-ips \
    --nat-all-subnet-ip-ranges \
    --enable-logging \
    --region=$REGION
    
    
echo "Definindo ip pra vpc."    
gcloud compute addresses create moodle-managed-range \
  --global \
  --purpose=VPC_PEERING \
  --addresses=$MOODLE_MYSQL_MANAGED_PEERING_RANGE \
  --prefix-length=24 \
  --description="Moodle Managed Services" \
  --network=$VPC_NAME

echo "Conectando o ip."  
gcloud services vpc-peerings connect \
  --service=servicenetworking.googleapis.com \
  --ranges=moodle-managed-range \
  --network=$VPC_NAME
 
 echo "Define o ip para o filestore."
 gcloud compute addresses create moodle-managed-range-filestore \
  --global \
  --purpose=VPC_PEERING \
  --addresses=$MOODLE_FILESTORE_MANAGED_PEERING_RANGE \
  --prefix-length=24 \
  --description="Moodle Managed Services" \
  --network=$VPC_NAME
 
echo "Atualiza a conexão do range do filestore e do sql.  "
 gcloud services vpc-peerings update \
  --service=servicenetworking.googleapis.com \
  --ranges=moodle-managed-range,moodle-managed-range-filestore \
  --network=$VPC_NAME
