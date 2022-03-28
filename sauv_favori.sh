#!/bin/bash

. functions.sh

if [ $# != "0" ];then

			while getopts "a:c:rlhgms:nv" opt 
			do
			
					case $opt in
					v)
					version
					;;
					n)
					renommer
					;;
					s)
					sauvimage $2
					;;
					a)
					ajouter $2
					;;
					l)
					afficherfav
					;;
					r)
					supprimer
					;;
					c)
					aller $2
					;;
					m)
					menu
					while (true)
	do
	echo "donner votre choix"
	read choix
	
		case $choix in
			1)
		clear
		menu
			echo "donner le chemin du fichier/dossier a ajouter au favoris"
	read path
		ajouter $path
			;;
			2)
				clear
				menu
				echo "donner le chemin du fichier/dossier a acceder"
				read path
				aller $path
				;;
			3)
			clear
			menu
			supprimer
			;;
			4)
			clear
			menu
			afficherfav
			;;
			5)
	clear
	menu
	helptext
			;;
			
			6)
			clear
			menu
			graph
			;;
			7)
			clear
			menu
			echo "donner le chemin du l'image a sauvgarder :"
			read path
			sauvimage $path 
			;;
			8)
			clear
			menu
			renommer
			;;
			9)
			clear
			menu
			version
			;;
			
			0)
	clear
	echo "Au revoir ($USER)"
			exit
			;;


			*)
	clear
	menu
	echo "choix incorrect!!!!!!"
			;;

	esac
	done
	;;
	
				h)
				helptext
				;;
				g)
				graph
				;;
	esac
	done
else show_usage
fi





		
			
		
