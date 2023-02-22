#########################################################
# Deploying Moodle With Helm
#########################################################
source /deploy/moodle-on-gcp/0-infra/envs.sh

echo "Opening file..."
sleep 5s

vim /deploy/moodle-on-gcp/5-helm/moodle-values.yaml

echo "Deploying Moodle..."
/deploy/moodle-on-gcp/5-helm/moodle-helm-install.sh


echo "Press CTRL+C to exit..."
echo "Just go to the end when you should be able to see your pods properly running,"
echo "<a href='https://github.com/google/moodle-on-gcp/blob/main/docs/install-moodle-helm.md'>Documentation</a>"
kubectl get pod -n moodle -w


