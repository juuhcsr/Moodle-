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
$(ColorGreen '1)') Atualizar variáveis.
$(ColorGreen '2)') Implantar NameSpace NS.
$(ColorGreen '3)') Implantar PV.
$(ColorGreen '4)') Implantar PVC.
$(ColorGreen '5)') Implantar Moodle com Helm.
$(ColorGreen '6)') Implantar configuração de backend.
$(ColorGreen '7)') Implantar Ingress - Load balance.
$(ColorGreen '8)') Prover um novo certificado SSL gerenciado pelo Google Cloud.
$(ColorGreen '9)') Habilitar escala horizontal para Pods.
$(ColorGreen '10)') Configurar Redis.
$(ColorGreen '11)') Estou com pressa (faz tudo de uma vez, garanta que as variáveis foram preenchidas)
$(ColorGreen '12)') Verificar instalação
$(ColorGreen '0)') Sair
$(ColorBlue 'Escolha uma opção:') "

        read a
        case $a in

			1) ./Deploy/1-variables_envs.sh ; menu ;;
			2) ./Deploy/10-deploy-ns.sh ; menu ;;
			3) ./Deploy/11-deploy-pv.sh ; menu ;;
			4) ./Deploy/12-deploy-pvc.sh ; menu ;;
			5) ./Deploy/13-deploy-moodle-helm.sh ; menu ;;
			6) ./Deploy/14-deploy-backend.sh ; menu ;;
			7) ./Deploy/15-deploy-cloud-lb.sh ; menu ;;
			8) ./Deploy/16-deploy-ssl-redirect.sh ; menu ;;
			9) ./Deploy/17-deploy-hpa.sh ; menu ;;
			10) ./Deploy/18-redis.sh ; menu ;;
			#19) ./Deploy/ ; menu ;;
			11) ./Deploy/hurry_up.sh ; menu ;;
			12) ./Deploy/teste.sh ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}
# Call the menu function
menu
