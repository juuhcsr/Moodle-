#########################################################
# Provisioning a new certificate managed by Google Cloud
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh

echo "-----------------------------------------------------"
echo "Preencha o arquivo com os valores do load balance"                                      
echo "-----------------------------------------------------"
sleep 2s
echo "abrindo o arquivo"
sleep 1s

nano ./deploy/moodle-on-gcp/7-ssl-certificate-and-redirect/google-managed-ssl-certificate.yaml 
echo "-------------------------------"
echo "Aplicando configurações do ssl."
echo "-------------------------------"

kubectl apply -f ./deploy/moodle-on-gcp/7-ssl-certificate-and-redirect/google-managed-ssl-certificate.yaml
echo "------------------------------------"
echo "Aplicando configurações do frontend."
echo "------------------------------------"

kubectl apply -f ./deploy/moodle-on-gcp/7-ssl-certificate-and-redirect/frontendconfig-redirect-http-to-https.yaml


'
lb_ip = `gcloud compute addresses describe moodle-ingress-ip \
>     --format="get(address)" \
>     --global`


cat <<EOF> ./deploy/moodle-on-gcp/-ssl-certificate-and-redirect/google-managed-ssl-certificate.yaml
spec:
  domains:
    # any domain name you have availabe to use:
    #- somedomain.somesite.com
    # ie.
    # www.mymoodlesite.com
    # or
    #- anything-you-want.<your-lb-external-ip-address>.nip.io
    # ie.
    - moodle.$lb_ip.nip.io
EOF
kubectl apply -f ./deploy/moodle-on-gcp/-ssl-certificate-and-redirect/frontendconfig-redirect-http-to-https.yaml
kubectl apply -f ./deploy/moodle-on-gcp/-ssl-certificate-and-redirect/google-managed-ssl-certificate.yaml
echo "Pressione CTRL+C para sair..."
echo "Just go to the end when you should be able to see your certificate properly running with status ACTIVE."
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/provisioning-certificate-forcing-https.md'>Documentation</a>"
kubectl get managedcertificate -n moodle -w
'



