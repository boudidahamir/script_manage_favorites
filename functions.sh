#!/bin/bash



menu()
{
echo "                 ~~~~~~~~~~~~~~~~~~~ HELLO ($USER) ~~~~~~~~~~~~~~~~~~~                "

echo "                   1) ajouter au favori                                               "
echo "                   2) aller au fichier/dossier du favori                              "
echo "                   3) supprimer de la liste favori                                    "
echo "                   4) afficher la liste des favoris                                   "
echo "                   5) Help                                                            "
echo "                   6) Afficher le menu graphique                                      "
echo "                   7) Sauvgarder une image                                            "
echo "                   8) renommer une image                                              "
echo "                   9) afficher nom des auteur et versions du code                     "
echo "                   0) Quit                                                            "
echo "                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~               "
}

helptext()
{

cat help.txt

}

helpgraph()
{
yad --title="Projet 12 :help" --center --no-buttons  --text="
-1) -a : ajouter au favori
-2) -c : aller au fichier/dossier du favori 
-3) -r : supprimer de la liste favori
-4) -l : afficher la liste des favoris
-5) -h : Help
-6) -g : Afficher le menu graphique
  - -m : Afficher le menu textuel
-7) -s : Sauvegarder une image
-8) -n : renommer une image
-9) -v : Afficher la version et les noms des acteurs
-0) Quitter"
}

graph()
{
	yad --text="Chose an option:" \
			--center \
      --width="20" --height="20" \
    	--window-icon="$backg" --image="$backg" --image-on-top \
		--button=gtk-cancel:1 \
		--button=gtk-help:2 \
		--button="ajouter au favori":3 \
		--button="aller au fichier/dossier du favori":4 \
		--button="supprimer de la liste favori":5 \
		--button="renommer une image":6 \
		--button=gtk-save:7 \
		--button="afficher la liste des favoris":8 \
    --button="afficher nom des auteur et versions du code":9 \
		--title "Projet 12" \

		boutton=$?


			[[ $boutton -eq 1 ]] && return


			if [[ $boutton -eq 2 ]]; then
                        helpgraph
                        graph

                        elif  [[ $boutton -eq 3 ]]; then
                        ajout=$(yad --entry --title='AJOUT' --text='donner le chemin du fichier/dossier a ajouter au favoris' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        ajout=$(echo "$ajout")

                        ajoutergraph $ajout
                        graph

                        elif  [[ $boutton -eq 4 ]]; then
                                                chem=$(yad --entry --title='aller' --text='donner le chemin du fichier/dossier a acceder' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        chem=$(echo "$chem")
                        allergraph $chem
                        graph

                        elif  [[ $boutton -eq 5 ]]; then
                        supprimergraph
                        graph

                        elif  [[ $boutton -eq 6 ]]; then
                        renommergraph
                        graph

                        elif  [[ $boutton -eq 7 ]]; then
                                                                        chem=$(yad --entry --title='aller' --text='donner le chemin du limage a sauvgarder :' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        chem=$(echo "$chem")
                        sauvimagegraph $chem
                        graph

                        elif  [[ $boutton -eq 8 ]]; then
                        afficherfavgraph
                        graph
                        elif  [[ $boutton -eq 9 ]]; then
                        versiongraph
                        graph



fi

}

ajoutergraph()
{

if ! [[ $1 = *" "* ]] ;
then
echo $1
	if [[ -e $1 ]];
	then
		if grep "$1" "save.txt" ; then
		yad --text="ce fichier/dossier existe deja dans la liste des favoris" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
		else
			echo $1 >> save.txt
		fi
	else 
	yad --text="le fichier n'existe pas" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
	 	
	 fi
   
elif [[ $1 = *" "* ]]; then
	yad --text="le chemin contient des espaces" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \
	result=$(sed "s/ //g" <<< $1)
	 if ! [[ -e $result ]] ; then
	--text= "et il n'existe pas " 
	fi
fi
}


ajouter()
{

if ! [[ $1 = *" "* ]] ;
then
echo $1
	if [[ -e $1 ]];
	then
		if grep "$1" "save.txt" ; then
			echo "ce fichier/dossier existe deja dans la liste des favoris"
		else
			echo $1 >> save.txt
		fi
	else 
	
	 	echo "le fichier n'existe pas"
	 fi
   
elif [[ $1 = *" "* ]]; then
	echo "le chemin contient des espaces"
	result=$(sed "s/ //g" <<< $1)
	 if ! [[ -e $result ]] ; then
	echo "et il n'existe pas " 
	fi
fi
}



show_usage()
{
	echo "sauv_favori: [-h|--help] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.."
}

aller()
{
if ! [[ $1 = *" "* ]] ;
then
	if [[ -e $1 && -d $1 ]];
	then
		
		if grep "$1" "save.txt" ; then
		n="cd $1"
		gnome-terminal -- bash -c "$n; exec bash"
		else
			echo "ce fichier/dossier n'existe pas dans la liste des favoris"
		fi
	else 
	
	 	echo "le fichier n'existe pas"
	 fi
   
elif [[ $1 = *" "* ]]; then
	echo "le chemin contient des espaces"
	result=$(sed "s/ //g" <<< $1)
	 if ! [[ -e $result ]] ; then
	echo "et il n'existe pas " 
	fi
fi
}

allergraph()
{
if ! [[ $1 = *" "* ]] ;
then
	if [[ -e $1 && -d $1 ]];
	then
		if grep "$1" "save.txt" ; then
		n="cd $1"
		gnome-terminal -- bash -c "$n; exec bash"
		else
			yad --text="ce fichier/dossier n'existe pas dans la liste des favoris" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
			
		fi
	else 
	
	yad --text="le fichier n'existe pas" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
	 	
	 fi
   
elif [[ $1 = *" "* ]]; then
	yad --text="le chemin contient des espaces" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
	result=$(sed "s/ //g" <<< $1)
	 if ! [[ -e $result ]] ; then
	 	yad --text="et il n'existe pas " \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
	fi
fi
}

supprimer()
{
		echo "donner le chemin du fichier/dossier a supprimer"
	read path
if grep "$path" "save.txt" ; then

	touch save2.txt
	sed "\:$path:d" "save.txt" >> save2.txt
	rm save.txt
	touch save.txt
	sed "\:$path:d" "save2.txt" >> save.txt
	rm save2.txt
	return
		else
			echo "ce fichier/dossier n'existe pas dans la liste des favoris"
		fi
	
}

supprimergraph()
{
                                                path=$(yad --entry --title='supprimer' --text='donner le chemin du fichier/dossier a supprimer' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        path=$(echo "$path")
if grep "$path" "save.txt" ; then

	touch save2.txt
	sed "\:$path:d" "save.txt" >> save2.txt
	rm save.txt
	touch save.txt
	sed "\:$path:d" "save2.txt" >> save.txt
	rm save2.txt
	return
		else
			 	yad --text="ce fichier/dossier n'existe pas dans la liste des favoris" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
		fi
	
}

afficherfav()
{
echo "LA LISTE DES FAVORIS :"
cat save.txt
}

afficherfavgraph()
{

	 	yad --text='LA LISTE DES FAVORIS :' \
	 	--text-info < save.txt \
			--center \
      --width="200" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
}

sauvimage()
{
echo ${1##*/}
if [[ -e "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" ]]; then 
echo "cette image existe deja dans les favoris"

elif ! [[ -e "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" ]]; then 
W=`identify $1 | cut -f 3 -d " " | sed s/x.*//`
H=`identify $1 | cut -f 3 -d " " | sed s/.*x//`
echo 
if [[ $(( W*H )) -gt 49000 ]]; then
echo "changer la resolution de l'image"
echo "donne le H"
read newh
echo "donne le W"
read neww
cp $1 "/home/$USER/Desktop/sauv_favori/favori_image"
convert "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" -resize "$newh"x"$neww" "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}"
else cp $1 "/home/$USER/Desktop/sauv_favori/favori_image"
fi
fi
}

sauvimagegraph()
{
echo ${1##*/}
if [[ -e "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" ]]; then 

			 	yad --text="cette image existe deja dans les favoris" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 


elif ! [[ -e "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" ]]; then 
W=`identify $1 | cut -f 3 -d " " | sed s/x.*//`
H=`identify $1 | cut -f 3 -d " " | sed s/.*x//`
echo 
if [[ $(( W*H )) -gt 49000 ]]; then
                                                newh=$(yad --entry --title='sauvgrade' -text='changer la resolution de limage' --text='donne le H' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        newh=$(echo "$newh")

                                                neww=$(yad --entry --title='sauvgrade' --text='donne le W' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        neww=$(echo "$neww")
cp $1 "/home/$USER/Desktop/sauv_favori/favori_image"
convert "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}" -resize "$newh"x"$neww" "/home/$USER/Desktop/sauv_favori/favori_image/${1##*/}"
else cp $1 "/home/$USER/Desktop/sauv_favori/favori_image"
fi
fi
}

renommer()
{
echo "donner le chemin de l'image a renommer"
read renom
if [ -e $renom ]; then
echo "donner le nouveau nom"
read nom
mv $renom "/home/$USER/Desktop/sauv_favori/favori_image/$nom""_$(date +'%d-%m-%Y')_$(date +'%r').jpg"
else echo "cette image n'exiset pas dans les favoris"
fi
}

renommergraph()
{
                                                renom=$(yad --entry --title='renommer' --text='donner le chemin de limage a renommer :' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        renom=$(echo "$renom")
if [ -e $renom ]; then
                                                nom=$(yad --entry --title='renommer' --text='donner le nom' --text-align="center" --no-escape --mouse --undecorated --skip-taskbar --on-top)
                        nom=$(echo "$nom")
mv $renom "/home/$USER/Desktop/sauv_favori/favori_image/$nom""_$(date +'%d-%m-%Y')_$(date +'%r').jpg"
else 
			 	yad --text="cette image n'exiset pas dans les favoris" \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
fi
}

version()
{
cat version.txt 
}

versiongraph()
{
yad --text-info < version.txt \
			--center \
      --width="20" --height="200" \
    	--window-icon="$backg" --image="$backg" --image-on-top \ 
}



