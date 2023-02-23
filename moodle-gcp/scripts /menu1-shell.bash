#!/bin/bash
##
##
server_name=$(hostname)
##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'
##
# Color Functions
##
ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}
menu(){
echo "#########################################################"
echo "#            Menu de instlação do moodle        -        #"
echo "#########################################################"
echo -ne "
Menu do moodle no gcp escolha a opção 
$(ColorGreen '1)') Editar as variáveis
$(ColorGreen '2)') Setup inicial
$(ColorGreen '3)') Implantar recursos de rede.
$(ColorGreen '4)') Implantar servidor linux.
$(ColorGreen '5)') Configurar permissões.
$(ColorGreen '6)') Implantar cluster GKE-Kubernetes.
$(ColorGreen '7)') Implantar Cloud SQL - Mysql.
$(ColorGreen '8)') Implantar FILESTORE - NFS.
$(ColorGreen '9)') Implantar Artifact Registry e imagem Moodle.
$(ColorGreen '10)') Implantar NameSpace NS.
$(ColorGreen '11)') Implantar PV.
$(ColorGreen '12)') Implantar PVC.
$(ColorGreen '13)') Implantar Moodle com Helm.
$(ColorGreen '14)') Implantar configuração de backend.
$(ColorGreen '15)') Implantar Ingress - Balanceador de carga em nuvem.
$(ColorGreen '16)') Prover um novo certificado gerenciado pelo Google Cloud.
$(ColorGreen '17)') Habilitar escala horizontal para Pods.
$(ColorGreen '18)') Configurar Redis.
$(ColorGreen '20)') Estou com pressa (faz tudo de uma vez, garanta que as variáveis foram preenchidas)
$(ColorGreen '21)') Verificar instalação
$(ColorGreen '0)') Sair
$(ColorBlue 'Escolha uma opção:') "

        read a
        case $a in
	        1) ./Deploy/1-variables_envs.sh ; menu ;;
	        2) ./Deploy/2-initial.sh ; menu ;;
	        3) ./Deploy/3-network.sh ; menu ;;
	        4) ./Deploy/4-deploy-server.sh ; menu ;;
	        5) ./Deploy/5-permissions.sh ; menu ;;
			6) ./Deploy/6-gke-kubernets.sh ; menu ;;
			7) ./Deploy/7-cloud-sql.sh ; menu ;;
			8) ./Deploy/8-filestore-nfs.sh ; menu ;;
			9) ./Deploy/9-artifact-registry.sh ; menu ;;
			10) ./Deploy/10-deploy-ns.sh ; menu ;;
			11) ./Deploy/11-deploy-pv.sh ; menu ;;
			12) ./Deploy/12-deploy-pvc.sh ; menu ;;
			13) ./Deploy/13-deploy-moodle-helm.sh ; menu ;;
			14) ./Deploy/14-deploy-backend.sh ; menu ;;
			15) ./Deploy/15-deploy-cloud-lb.sh ; menu ;;
			16) ./Deploy/16-deploy-ssl-redirect.sh ; menu ;;
			17) ./Deploy/17-deploy-hpa.sh ; menu ;;
			18) ./Deploy/18-redis.sh ; menu ;;
			#19) ./Deploy/ ; menu ;;
			20) ./Deploy/hurry_up.sh ; menu ;;
			21) ./Deploy/teste.sh ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}
# Call the menu function
menu
