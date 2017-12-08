#!/bin/bash
#noir 0;30 rouge 0;31 vert 0;32 jaune 0;33 bleu 0;34 rose 3;35 cyan 0;36 gris 0;37
#0 parametre par defaut 1 gras 4 souligner 5 clignotant 7 surligner

#Brown 0;33
cBROWN='\033[0;33m';
cRED='\033[0;31m';
cBLUE='\033[0;34m';
cCYAN='\033[0;36m';
cGREEN='\033[0;32m';
fGREY='\033[0;47m';
NC='\033[0m' # No Color

echo -e "${cGREEN}Initialisation du Script... vagrant.sh${NC}";
echo -e "${cBLUE}Vous etes dans `pwd` ${NC}";

#Installation de VirtualBox
nameVirtualBox="virtualbox";
read -p $'\e[33mVoulez vous installer Virtualbox Oui/non :\e[36m[1/2] [nomVersion] \e[0m' installVirtualBox nameVirtualBox;
if [ $installVirtualBox = 1 ]; then
    sudo apt-get install $nameVirtualBox;
elif [ $installVirtualBox = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi

#Suppression de Vagrant
validationDeleteVagrant="0";
while [ $validationDeleteVagrant != 1 ]
do
  read -p $'\e[31mVoulez vous supprimer une Vagrant Oui/Non :\e[36m[1/2]\e[0m' deleteVagrant;
  if [ $deleteVagrant = 1 ]; then
      vagrant global-status

      validationID="0";
      while [ $validationID != 1 ]
      do
          read -p $'\e[33mVeuillez entrer \e[36m [idVagrant] \e[0m' deleteVagrant;
          read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${deleteVagrant}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationID;
      done
      vagrant destroy $deleteVagrant
  else
      echo -e "${cBLUE}Suppression annulée${NC}";
      validationDeleteVagrant="1";
  fi
done

#Installation de Vagrant
nameVagrant="vagrant";
read -p $'\e[33mVoulez vous installer Vagrant Oui/Non :\e[36m[1/2] [nomVersion] \e[0m' installVagrant nameVagrant;
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
    echo -e "${cBLUE}Creation du fichier Vagrant${NC}"

else
    echo -e "${cRED}Un Vagrantfile existe déjà dans ce dossier.${NC}"
    read -p $'\e[36m[1]\e[33mSupprimer \e[36m[2]\e[33mIgnorer \e[36m[3]\e[33mQuitter le bash \e[0m' miniMenu;

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
OS=('ubuntu\/xenial64' 'ubuntu\/trusty64');

validationBox="0";
validationDossier="0";
validationChemin="0";
validationIP="0";


tableauOS=('ubuntu/xenial64\n' 'ubuntu/truty64\n' 'laravel/homestead\n' 'debian/jessie64\n');

while [ $validationBox != 1 ]
do
    read -p $'\e[33mVeuillez choisir \e[36m [1]\e[33m ubuntu/xenial64 \e[36m [2]\e[33m  ubuntu/trusty64 :\e[36m [nomBox] \e[0m' choixOS;
    if [ $choixOS = 0 ]; then #valeur par defaut 1
        echo -e ${BROWN}${tableauOS[*]}${NC};
    else
      read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${choixOS}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationBox;
    fi
done

while [ $validationDossier != 1 ]
do
    read -p $'\e[33mVeuillez entrer une passerelle \e[36m [1]\e[33m data \e[33m :\e[36m [nomBox] \e[0m' dossierPasserelle;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${dossierPasserelle}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDossier;
done

while [ $validationChemin != 1 ]
do
    read -p $'\e[33mVeuillez entrer une passerelle \e[36m [1]\e[33m var/www/html :\e[36m [nomBox] \e[0m' cheminPasserelle;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${cheminPasserelle}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationChemin;
done

while [ $validationIP != 1 ]
do
    read -p $'\e[33mVeuillez une adresse IP \e[36m [1]\e[33m 192.168.33.10 :\e[36m [nomBox] \e[0m' adresseIP;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${adresseIP}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationIP;
done

#Vagrantfile Modification de la box de "base"
if [ $choixOS = 1 ]; then #valeur par defaut 1
    changeOS="s/base/${OS[0]}/g Vagrantfile";
elif [ $choixOS = 2 ]; then #valeur par defaut 2
    changeOS="s/base/${OS[1]}/g Vagrantfile";
else #ajout du caractère d'echappement
    choixOS=$(echo $choixOS | sed -e's=\/=\\\/=g');
    changeOS="s/base/$choixOS/g Vagrantfile";
fi

#Vagrant Modification du dossier et de la passerelle
if [ $dossierPasserelle = 1 ]; then #valeur par defaut 1
    dossierPasserelle="data";
    changeDossier="s/..\/data/$dossierPasserelle/g Vagrantfile";
else #ajout du caractère d'echappement
    changeDossier="s/..\/data/$dossierPasserelle/g Vagrantfile";
fi

if [ $cheminPasserelle = 1 ]; then #valeur par defaut 1
    cheminPasserelle="var\/www\/html";
    changeChemin="s/vagrant_data/$cheminPasserelle/g Vagrantfile";
else #ajout du caractère d'echappement
    cheminPasserelle=$(echo $cheminPasserelle | sed -e's=\/=\\\/=g');
    changeChemin="s/vagrant_data/$cheminPasserelle/g Vagrantfile";
fi

# Verification de la presence du dossier avant mkdir
#Creation de la passerelle
if [ ! -d $dossierPasserelle ]; then
    mkdir $dossierPasserelle;
    echo -e "${cBLUE}Creation du fichier Vagrant${NC}"

else
    echo -e "${cRED}Le dossier $dossierPasserelle existe déjà !${cNC}"
    read -p $'\e[36m[1]\e[33mSupprimer \e[36m[2]\e[33mIgnorer \e[36m[3]\e[33mQuitter le bash \e[0m' miniMenu;

    #Suppression puis creation de la passerelle
    if [ $miniMenu = 1 ]; then
        rm -rf $dossierPasserelle;
        mkdir $dossierPasserelle;
        echo -e "${cRED}Le dossier $dossierPasserelle a été supprimé${NC}";
    #On continue le script
    elif [ $miniMenu = 2 ]; then
        echo -e "${cBLUE}Ignorer le dossier $dossierPasserelle${NC}";
    #Fermeture du bash
    elif [ $miniMenu = 3 ]; then
        echo -e "${cRED}Fermeture du bash${NC}";
        exit 1;
    else
        echo -e "${cBLUE}Ignorer le dossier $dossierPasserelle${NC}";
    fi
fi

if [ $adresseIP = 1 ]; then #valeur par defaut 1
    adressIP="192.168.33.10";
fi
changeIP="s/192.168.33.10/$adresseIP/g Vagrantfile";

#apache et wpcli

sed -i -e $changeOS;

sed -i -e $changeDossier;
sed -i -e $changeChemin;
sed -i -e $changeNetwork;
sed -i -e $changeIP;

sed -i -e "/private_network/s/^  # /  /g" Vagrantfile;
sed -i -e "/synced_folder/s/^  # /  /g" Vagrantfile;
#sed -i -e "/config.vm.provision/s/^  # /  /g" Vagrantfile;
#sed -i -e "/apt-get\ update/s/^  # /  /g" Vagrantfile;
#sed -i -e "/apt-get\ update/s/^  # /  /g" Vagrantfile;

#vagrant up
echo -e "${cGREEN}Demarrage de la VM
Demarrage de la connexion SSH${NC}
${cBLUE}Un menu sera affiché à la sortie du SSH (exit)${NC}";
vagrant up
#vagrant up && vagrant ssh

#demander d'eteindre ou pas la vagrant
vagrantStatut="ssh";

while [ $vagrantStatut != 0 ]
do
    echo -e "${cBROWN}Que voulez vous faire ?
    ${cCYAN}1${cBROWN}-Demarrer la VM (vagrant up)
    ${cCYAN}2${cBROWN}-Connexion SSH
    ${cCYAN}3${cBROWN}-Mise en veille VM
    ${cCYAN}4${cBROWN}-Relancer VM
    ${cCYAN}5${cBROWN}-Liste des box
    ${cCYAN}6${cBROWN}-Copie bash Apache2 et WPCLI
    ${cCYAN}8${cBROWN}-Supprimer Vagrant
    ${cCYAN}9${cBROWN}-Eteindre la VM
    ${cCYAN}0${cBROWN}-Quitter (implique Eteindre VM)${NC}";
    read -p "... " vagrantStatut
    if [ $vagrantStatut = 1 ]; then
        vagrant up
        echo -e "${cGREEN}VM allumé${NC}";

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
        echo -e "${cBLUE}Liste des boxs${NC}";
        vagrant box list

    #Copie de bash dans la vagrant
    elif [ $vagrantStatut = 6 ]; then
        echo -e "${cGREEN}Copie du bash Apache2 et wpcli${NC}";
        cp apache2.sh $dossierPasserelle;
        cp wpcli.sh $dossierPasserelle;
        echo -e "${cBLUE}Connectez vous en ssh.${NC}";
        echo -e "${cBLUE}Les bash sont dans votre dossier passerelle.${NC}";
        echo -e "${cBLUE}ex: /var/www/html${NC}";

    #Suppression de Vagrant
    elif [ $vagrantStatut = 8 ]; then
        validationDeleteVagrant="0";
        while [ $validationDeleteVagrant != 1 ]
        do
          read -p $'\e[31mVoulez vous supprimer une Vagrant Oui/Non :\e[36m[1/2] \e[0m' deleteVagrant;
          if [ $deleteVagrant = 1 ]; then
              vagrant global-status

              validationID="0";
              while [ $validationID != 1 ]
              do
                  read -p $'\e[33mVeuillez entrer \e[36m [idVagrant] \e[0m' deleteVagrant;
                  read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${deleteVagrant}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationID;
              done
              vagrant destroy $deleteVagrant
              echo -e "${cRED}La vagrant est normalement supprimé${NC}";
              vagrant global-status
              echo -e "${cRED}Si le vagrant persiste, relancer la suppression pour finaliser.${NC}";
          else
              echo -e "${cBLUE}Suppression annulée${NC}";
              validationDeleteVagrant="1";
          fi
        done


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
