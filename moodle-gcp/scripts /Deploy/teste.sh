echo "Verificando instalação"
echo "----------------------"
echo "Verificando o Volume (PV)"
kubectl get pv
sleep 7s
echo "----------------------"
echo "Verificando o Namespace "
kubectl get ns
sleep 7s
echo "----------------------"
echo "Verificando o Volume (PVC)"
kubectl get pvc -n moodle
sleep 7s
echo "----------------------"
echo "Verificando a instalação dos cluster kubernetes (HELM)"
kubectl get pod -n moodle
sleep 7s
echo "----------------------"
echo "Verificando a configuração do backend"
kubectl get backendconfig -n moodle
sleep 7s
echo "----------------------"
echo "Verificando o Load balance"
kubectl get backendconfig -n moodle
sleep 7s
echo "----------------------"
echo "Verificando a configuração do ssl"
kubectl get managedcertificate -n moodle
sleep 7s
echo "----------------------"
echo "Verificando a configuração frontend"
kubectl get frontendconfig -n moodle
sleep 7s
echo "----------------------"
echo "Verificando o escalonamento horizando (HPA)"
kubectl get hpa -n moodle
sleep 7s

