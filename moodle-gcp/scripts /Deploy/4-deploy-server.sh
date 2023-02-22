#########################################################
# Deploy instance for deploy moodle
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

gcloud compute instances create deploy-1  \
    --image-family=debian-11\
     --image-project=debian-cloud \
    --project=moodle-gcp2 \
    --machine-type=e2-medium \
    --network-interface=network-tier=STANDARD,subnet=$SUBNET_NAME \
    --zone=$ZONE \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --reservation-affinity=any \
    --metadata=startup-script='#! /bin/bash
  apt update
  apt install -y git
  mkdir /deploy
  # a editar !!!!
  git clone https://github.com/google/moodle-on-gcp.git /deploy/moodle-on-gcp

  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  apt-get install apt-transport-https --yes
  sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  apt-get install kubectl
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-415.0.0-linux-x86_64.tar.gz
  tar -xf google-cloud-cli-415.0.0-linux-x86.tar.gz
  ./google-cloud-sdk/install.sh
CORAÇÃO
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
