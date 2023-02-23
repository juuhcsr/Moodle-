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
echo "# Menu de instlação do moodle   Máquina virtual   -     #"
echo "#########################################################"
echo -ne "
Menu do moodle no gcp escolha a opção 
$(ColorGreen '1)') Implantar NameSpace NS.
$(ColorGreen '2)') Implantar PV.
$(ColorGreen '3)') Implantar PVC.
$(ColorGreen '4)') Implantar Moodle com Helm.
$(ColorGreen '5)') Implantar configuração de backend.
$(ColorGreen '6)') Implantar Ingress - Balanceador de carga em nuvem.
$(ColorGreen '7)') Prover um novo certificado gerenciado pelo Google Cloud.
$(ColorGreen '8)') Habilitar escala horizontal para Pods.
$(ColorGreen '9)') Configurar Redis.
$(ColorGreen '10)') Estou com pressa (faz tudo de uma vez, garanta que as variáveis foram preenchidas)
$(ColorGreen '11)') Verificar instalação
$(ColorGreen '0)') Sair
$(ColorBlue 'Escolha uma opção:') "

        read a
        case $a in
			1) ./Deploy/10-deploy-ns.sh ; menu ;;
			2) ./Deploy/11-deploy-pv.sh ; menu ;;
			3) ./Deploy/12-deploy-pvc.sh ; menu ;;
			4) ./Deploy/13-deploy-moodle-helm.sh ; menu ;;
			5) ./Deploy/14-deploy-backend.sh ; menu ;;
			6) ./Deploy/15-deploy-cloud-lb.sh ; menu ;;
			7) ./Deploy/16-deploy-ssl-redirect.sh ; menu ;;
			8) ./Deploy/17-deploy-hpa.sh ; menu ;;
			9) ./Deploy/18-redis.sh ; menu ;;
			#19) ./Deploy/ ; menu ;;
			10) ./Deploy/hurry_up.sh ; menu ;;
			11) ./Deploy/teste.sh ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}
# Call the menu function
menu
