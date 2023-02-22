#########################################################
# Deploying Persistent Volume (PV)
#########################################################
source /deploy/moodle-on-gcp/0-infra/envs.sh

echo "Connect to GKE cluster via command line and update local cluster credentials."
gcloud container clusters get-credentials $GKE_NAME \
    --region $REGION \
    --project $PROJECT_ID
    
    
#NFS_IP = `gcloud filestore instances describe $FILESTORE_NAME  --location=$ZONE --format=json | jq '.networks[0] .ipAddresses[0]' `
NFS_IP = `gcloud filestore instances describe moodle-nfs  --location=us-central1-a --format=get"(networks.ipAddresses[0])" `


cat <<EOF> /deploy/moodle-on-gcp/1-pv/pv-filestore.yaml
nfs:
    path: /moodleshare
    server: $NFS_IP # filestore's internal IP
EOF

echo "Press CTRL+C to exit..."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/deploying-persistent-volume.md'>Documentation</a>"

kubectl get pv -w
