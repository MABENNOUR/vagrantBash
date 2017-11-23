#!/bin/bash
#noir 0;30 rouge 0;31 vert 0;32 jaune 0;33 bleu 0;34 rose 3;35 cyan 0;36 gris 0;37
#0 parametre par defaut 1 gras 4 souligner 5 clignotant 7 surligner

#Brown 0;33
cBROWN='\033[0;33m';
cRED='\033[0;31m';
cBLUE='\033[0;34m';
cGREEN='\033[0;32m';
fGREY='\033[0;47m';
NC='\033[0m' # No Color

echo "Initialisation du Script...";

#Installation de VirtualBox
nameVirtualBox="virtualbox";
read -p "Voulez vous installer Virtualbox Oui/non [1/2] [nomVersion]" installVirtualBox nameVirtualBox;
if [ $installVirtualBox = 1 ]; then
    sudo apt-get install $nameVirtualBox;
elif [ $installVirtualBox = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi

#Installation de Vagrant
nameVagrant="vagrant";
read -p "Voulez vous installer Vagrant Oui/Non [1/2] [nomVersion]" installVagrant nameVagrant;
if [ $installVagrant = 1 ]; then
    sudo apt-get install $nameVagrant;
elif [ $installVagrant = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi

#VAGRANT-------------------------------------------------------

# Verification de la presence du Vagrantfile
if [ ! -f Vagrantfile ]; then
    #vagrant init 1> /dev/null
    echo "Creation du fichier Vagrant"

else
    echo "Un Vagrantfile existe déjà dans ce dossier."
    read -p "[1]Supprimer [2]Ignorer [3]Quitter le bash" miniMenu;

    if [ $miniMenu = 1 ]; then
        rm Vagrantfile;
        echo -e "${cRED}Vagrantfile supprimé${NC}";
    elif [ $miniMenu = 2 ]; then
        echo -e "${cBLUE}Ignorer Vagrantfile${NC}";
    elif [ $miniMenu = 3 ]; then
        echo -e "${cRED}Fermeture du bash${NC}";
        exit 1;
    else
        echo -e "${cBLUE}Ignorer Vagrantfile${NC}";
    fi
fi

#Initiation vagrant

vagrant init;
xenial="ubuntu\/xenial64";
trusty="ubuntu\/trusty64";


dossierPasserelle="data";

cheminPasserelle="var\/www\/html"

read -p "Veuillez choisir: [1] xenial64 [2] trusty64 " choixOS;

#Vagrantfile Modification de "base"
if [ $choixOS = 1 ]; then
    changeOS="s/base/$xenial/g Vagrantfile";
fi
if [ $choixOS = 2 ]; then
    changeOS="s/base/$trusty/g Vagrantfile"; 
fi

#Vagrant Modification du dossier et de la passerelle    
changeDossier="s/..\/data/$dossierPasserelle/g Vagrantfile";
changeChemin="s/vagrant_data/$cheminPasserelle/g Vagrantfile";

#Creation de la passerelle
mkdir $dossierPasserelle;

sed -i -e $changeOS;

sed -i -e $changeDossier;
sed -i -e $changeChemin;
sed -i -e $changeNetwork;

sed -i "/private_network/s/^  # /  /g" Vagrantfile;
sed -i "/synced_folder/s/^  # /  /g" Vagrantfile;



#vagrant up
echo -e "${cGREEN}Demarrage de la VM
Demarrage de la connexion SSH${NC}
${cBLUE}Un menu sera affiché à la sortie du SSH (exit)${NC}";
vagrant up && vagrant ssh

#demander d'eteindre ou pas la vagrant
vagrantStatut="ssh";

while [ $vagrantStatut != 0 ]
do
echo -e "${cBROWN}Que voulez vous faire ?
1-Demarrer la VM
2-Connexion SSH
3-Mise en veille VM
4-Relancer VM
5-Liste des box
9-Eteindre la VM
0-Quitter (implique Eteindre VM)${NC}";
read -p "... " vagrantStatut
if [ $vagrantStatut = 1 ]; then
    vagrant up
    echo -e "${cGREEN}VM alummé${NC}";

elif [ $vagrantStatut = 2 ]; then
    echo -e "${cGREEN}Connexion SSH en cours...${NC}";
    vagrant ssh

elif [ $vagrantStatut = 3 ]; then
    echo -e "${cBLUE}VM mise en veille${NC}";
    vagrant suspend

elif [ $vagrantStatut = 4 ]; then
    echo -e "${cGREEN}VM relancé${NC}";
    vagrant resume
 
#Affichage de toutes les vagrants en cours d'utilisation
elif [ $vagrantStatut = 5 ]; then
    echo -e "${cBLUE}Liste des boxs{NC}";
    vagrant box list
      

elif [ $vagrantStatut = 9 ]; then
    vagrant halt
    echo -e "${cRED}VM éteinte${NC}";



elif [ $vagrantStatut = 0 ]; then
    vagrant halt
    echo -e "${cRED}VM éteinte${NC}";
    echo -e "${cRED}Fermeture du batch...${NC}";
    
else
    echo "...";
fi
done

