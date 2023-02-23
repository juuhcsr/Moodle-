#########################################################
# Deploying Moodle With Helm
#########################################################
source ./deploy/moodle-on-gcp/0-infra/envs.sh
echo "-----------------------------------------------------"
echo "Preencha o arquivo dos valores do moodle"
echo "Algumas variáveis para copiar :"
echo "Registry = $REGION-docker.pkg.dev"
echo "Repository = $PROJECT_ID/moodle-filestore/moodle" 
echo "database-password: $MYSQL_ROOT_PASSWORD"
echo "database: $MYSQL_DB"                                        
echo "-----------------------------------------------------"
sleep 10s

nano ./deploy/moodle-on-gcp/5-helm/moodle-values.yaml

echo "Implantando o Moodle..."
cd ./deploy/moodle-on-gcp/5-helm
./moodle-helm-install.sh
#./deploy/moodle-on-gcp/5-helm/moodle-helm-install.sh


echo "Pressione CTRL+C para sair..."
echo "Just go to the end when you should be able to see your pods properly running,"
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/install-moodle-helm.md'>Documentation</a>"
kubectl get pod -n moodle -w


