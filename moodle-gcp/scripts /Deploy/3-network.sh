#########################################################
# NETWORK
#########################################################
source /deploy/moodle-on-gcp/0-infra/envs.sh 


echo "Creation of global IP address to be later attached to Cloud Load Balancer."
gcloud compute addresses create moodle-ingress-ip --global

echo "Enables networking services creation (if not enabled already)"
gcloud services enable servicenetworking.googleapis.com \
  &nbsp;--project=$PROJECT_ID

echo "Creates a new Virtual Private Network (VPC) and a subnet to host Moodle's resources."

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

echo "Create secondary ranges for the subnetwork to add to Google Kubernetes Engine (GKE)."
gcloud compute networks subnets update $SUBNET_NAME \
  --region $REGION \
  --add-secondary-ranges pod-range-gke-1=$GKE_POD_RANGE;
 
echo  "Authorizes the cluster to be reached by some VM in the VPC (this will be needed later for cluster configuration)."
 gcloud compute networks subnets update $SUBNET_NAME \
  --region $REGION \
  --add-secondary-ranges svc-range-gke-1=$GKE_SVC_RANGE;
  
 echo "Creates a router and NAT config for enabling cluster's outbound communication."
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
    
    
echo "Defines an IP address range for Filestore's VPC peering."    
gcloud compute addresses create moodle-managed-range \
  --global \
  --purpose=VPC_PEERING \
  --addresses=$MOODLE_MYSQL_MANAGED_PEERING_RANGE \
  --prefix-length=24 \
  --description="Moodle Managed Services" \
  --network=$VPC_NAME

echo "Attaches the range to the service networking API."  
gcloud services vpc-peerings connect \
  --service=servicenetworking.googleapis.com \
  --ranges=moodle-managed-range \
  --network=$VPC_NAME
 
 echo "Defines an IP address range for VPC peering for filestore."
 gcloud compute addresses create moodle-managed-range-filestore \
  --global \
  --purpose=VPC_PEERING \
  --addresses=$MOODLE_FILESTORE_MANAGED_PEERING_RANGE \
  --prefix-length=24 \
  --description="Moodle Managed Services" \
  --network=$VPC_NAME
 
echo "Updates the peering connection adding both SQL and Filestore ranges.  "
 gcloud services vpc-peerings update \
  --service=servicenetworking.googleapis.com \
  --ranges=moodle-managed-range,moodle-managed-range-filestore \
  --network=$VPC_NAME
