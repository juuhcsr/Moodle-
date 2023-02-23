#########################################################
# Deploy instance for deploy moodle
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

gcloud compute instances create deploy-1  \
    --image-family=debian-11\
     --image-project=debian-cloud \
    --project=$PROJECT_ID \
    --machine-type=e2-medium \
    --network-interface=network-tier=STANDARD,subnet=$SUBNET_NAME \
    --zone=$ZONE \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --reservation-affinity=any \
    --metadata=startup-script='
  #! /bin/bash
  apt update
  apt install -y git
  # a editar !!!!
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  apt-get install apt-transport-https --yes
  sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  apt-get install kubectl
  apt-get install docker
  apt-get install docker-compose
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  apt-get update
  apt-get install -y helm apt-transport-https ca-certificates gnupg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  apt-get update && sudo apt-get install -y google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin kubectl
  apt-get upgrade




 '
gcloud compute --project=$PROJECT_ID firewall-rules create moodle-allow-tcp --direction=INGRESS --priority=997 --network=$VPC_NAME --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0