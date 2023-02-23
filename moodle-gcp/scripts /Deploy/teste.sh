Echo "Verificando instalação"
Echo "----------------------"
Echo "Verificando o Volume (PV)"
kubectl get pv
sleep 7s
Echo "----------------------"
Echo "Verificando o Namespace "
kubectl get ns
sleep 7s
Echo "----------------------"
Echo "Verificando o Volume (PVC)"
kubectl get pvc -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando a instalação dos cluster kubernetes (HELM)"
kubectl get pod -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando a configuração do backend"
kubectl get backendconfig -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando o Load balance"
kubectl get backendconfig -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando a configuração do ssl"
kubectl get managedcertificate -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando a configuração frontend"
kubectl get frontendconfig -n moodle
sleep 7s
Echo "----------------------"
Echo "Verificando o escalonamento horizando (HPA)"
kubectl get hpa -n moodle
sleep 7s

