echo "Verificando instalação"
echo "----------------------"
echo "Verificando o Volume (PV)"
echo "----------------------"
kubectl get pv
sleep 4s
echo "----------------------"
echo "Verificando o Namespace "
echo "----------------------"
kubectl get ns
sleep 4s
echo "----------------------"
echo "Verificando o Volume (PVC)"
echo "----------------------"
kubectl get pvc -n moodle
sleep 4s
echo "----------------------"
echo "Verificando a instalação dos cluster kubernetes (HELM)"
echo "----------------------"
kubectl get pod -n moodle
sleep 4s
echo "----------------------"
echo "Verificando a configuração do backend"
echo "----------------------"
kubectl get backendconfig -n moodle
sleep 4s
echo "----------------------"
echo "Verificando o Load balance"
echo "----------------------"
kubectl get backendconfig -n moodle
sleep 4s
echo "----------------------"
echo "Verificando a configuração do ssl"
echo "----------------------"
kubectl get managedcertificate -n moodle
sleep 4s
echo "----------------------"
echo "Verificando a configuração frontend"
echo "----------------------"
kubectl get frontendconfig -n moodle
sleep 4s
echo "----------------------"
echo "Verificando o escalonamento horizando (HPA)"
echo "----------------------"
kubectl get hpa -n moodle
sleep 4s

