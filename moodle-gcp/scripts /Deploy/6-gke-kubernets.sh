#########################################################
# GKE - KUBERNETS
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "-----------------------------"
echo "Criando o cluster kubernetes."
echo "-----------------------------"
gcloud container clusters create $GKE_NAME \
  --release-channel=stable \
  --region=$REGION \
  --enable-dataplane-v2 \
  --enable-ip-alias \
  --enable-private-nodes \
  --enable-private-endpoint \
  --enable-master-global-access \
  --enable-autoscaling \
  --min-nodes=1 \
  --max-nodes=3 \
  --enable-autorepair \
  --monitoring=SYSTEM \
  --num-nodes=1 \
  --scopes=storage-rw,compute-ro \
  --enable-autorepair \
  --enable-intra-node-visibility \
  --machine-type=n1-standard-2 \
  --network=$VPC_NAME \
  --subnetwork=$SUBNET_NAME \
  --addons=HttpLoadBalancing,HorizontalPodAutoscaling,GcpFilestoreCsiDriver \
  --master-ipv4-cidr=$GKE_MASTER_IPV4_RANGE \
  --logging=SYSTEM,WORKLOAD \
  --cluster-secondary-range-name=pod-range-gke-1 \
  --services-secondary-range-name=svc-range-gke-1
  
  echo "------------------------------------------------"
  echo "Autorizando o cluster a conectar nas instâncias."
  echo "------------------------------------------------"
  gcloud container clusters update $GKE_NAME \
  --enable-master-authorized-networks \
  --master-authorized-networks $MASTER_AUTHORIZED_NETWORKS \
  --region=$REGION
  
gcloud container clusters get-credentials $GKE_NAME \
  --region $REGION \
  --project $PROJECT_ID


