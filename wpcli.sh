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

echo -e "${cGREEN}Initialisation du Script... wpcli.sh${NC}";
echo -e "${cBLUE}Vous etes dans `pwd` ${NC}";


#Installation de WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Verifier que tout fonctionne
read -p $'\e[33mVoulez vous vérifier que tout fonctionne Oui/Non :\e[36m[1/2] \e[0m' pharInfo;
if [ $pharInfo = 1 ]; then
    php wp-cli.phar --info;
elif [ $pharInfo = 2 ]; then
    echo -e "${cBLUE}Aucune vérification${NC}";
else
    echo -e "${cBLUE}Aucune vérification${NC}";
fi

#Rendre le fichier executable
chmod +x wp-cli.phar

#Déplacement dans le path
sudo mv wp-cli.phar /usr/local/bin/wp

#Verifier installations
read -p $'\e[33mVoulez vous vérifier cette installation Oui/Non :\e[36m[1/2] \e[0m' wpInfo;
if [ $wpInfo = 1 ]; then
    wp --info;
elif [ $wpInfo = 2 ]; then
    echo -e "${cBLUE}Aucune vérification${NC}";
else
    echo -e "${cBLUE}Aucune vérification${NC}";
fi


#Creation du dossier wp-cli
validationDossierWP="0";
while [ $validationDossierWP != 1 ]
do
    read -p $'\e[33mVeuillez entrer une passerelle \e[36m [1]\e[33m wpcli \e[33m :\e[36m [nomDossier] \e[0m' dossierWP;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${dossierWP}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDossierWP;
done

if [ $dossierWP = 1 ]; then #valeur par defaut 1
    dossierWP="wpcli";
fi

# Verification de la presence du dossier avant mkdir
#Creation de la passerelle
if [ ! -d $dossierWP ]; then
    mkdir $dossierWP;
    echo -e "${cBLUE}Le dossier $dossierWP a bien été créé.${NC}"

else
    echo -e "${cRED}Le dossier $dossierWP existe déjà !${cNC}"
    read -p $'\e[36m[1]\e[33mSupprimer \e[36m[2]\e[33mIgnorer \e[36m[3]\e[33mQuitter le bash \e[0m' miniMenu;

    #Suppression puis creation de la passerelle
    if [ $miniMenu = 1 ]; then
        rm -rf $dossierWP;
        mkdir $dossierWP;
        echo -e "${cRED}Le dossier $dossierWP a été supprimé${NC}";
    #On continue le script
    elif [ $miniMenu = 2 ]; then
        echo -e "${cBLUE}Ignorer le dossier $dossierWP${NC}";
    #Fermeture du bash
    elif [ $miniMenu = 3 ]; then
        echo -e "${cRED}Fermeture du bash${NC}";
        exit 1;
    else
        echo -e "${cBLUE}Ignorer le dossier $dossierWP${NC}";
    fi
fi

cd $dossierWP;
echo "Vous etes dans `pwd` ";


#choisir langue
validationLangWP="0";
#https://make.wordpress.org/polyglots/teams/
tableauLangue=('Afrikaans af\n' 'Albanian sq\n' 'Arabic ar\n' 'Basque eu\n' 'Belarusian bel\n' 'Bulgarian bg_BG\n' 'Catalan ca\n' 'Chinese zh_CN\n' 'Chinese Hong-Kong zh_HK\n' 'Chinese Taiwan zh_TW\n' 'Croatian hr\n' 'Danish da_DK\n' 'Dutch nl_NL\n' 'Dutch Belgium nl_BE\n'
'English Australia en_AU\n' 'English Canada en_CA\n' 'English New Zealand en_NZ\n' 'English South Africa en_ZA\n' 'English UK en_GB\n' 'Esperanto eo\n' 'Estonian et\n' 'Finnish fi\n' 'French Belgium fr_BE\n' 'French Canada fr_CA\n' 'French France fr_FR\n'
'Galician gl_ES\n' 'German de_DE\n' 'German Switzeland de_CH\n' 'Greek el\n' 'Gujarati gu\n' 'Hebrew he_IL\n' 'Hindi hi_IN\n' 'Indonesian id_ID\n' 'Italian it_IT\n' 'Japanese ja\n' 'Javanese jv_ID\n' 'Korean ko_KR\n' 'Lithuanian lt_LT\n' 'Malay ms_MY\n' 'Norwegian nb_NO\n'
'Polish pl_PL\n' 'Portuguese Brazil pt_BR\n' 'Portuguese Portugal pt_PT\n' 'Romanian ro_RO\n' 'Russian ru_RU\n' 'Serbian sr_RS\n' 'Slovak sk_SK\n' 'Slovenian sl_SI\n' 'Spanish Argentina es_AR\n' 'Spanish Colombia es_CO\n' 'Spanish Guatemala es_GT\n' 'Spanish Spain es_ES\n'
'Swedish sv_SE\n' 'Turkish tr_TR\n' 'Urdu ur\n' 'Vietnamese vi\n');
while [ $validationLangWP != 1 ]
do
    read -p $'\e[33mVeuillez selectionner la langue à installer \e[36m [0]\e[33m liste \e[36m [1]\e[33m fr_FR \e[33m :\e[36m [langue au format xxx_YY] \e[0m' langWP;
    if [ $langWP = 0 ]; then #valeur par defaut 1
        echo -e ${BROWN}${tableauLangue[*]}${NC};
    else
      read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${langWP}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationLangWP;
    fi
done

if [ $langWP = 1 ]; then #valeur par defaut 1
    langWP="fr_FR";
fi

wp core download --locale=$langWP;

#choix bdd user mdp
validationDBConfig="0";
while [ $validationDBConfig != 1 ]
do
    read -p $'\e[33mVeuillez entrer \e[36m [nomDataBase] [userDataBase] [passwordDataBase]\e[0m' nomDataBase userDataBase passwordDataBase;
    read -p $'\e[33mEtes vous sure vos informations : \e[34m '${nomDataBase}$' '${userDataBase}$' '${passwordDataBase}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDBConfig;
done
wp config create --dbname=$nomDataBase --dbuser=$userDataBase --dbpass=$passwordDataBase
echo -e "${cGREEN}Création du wp config.${NC}";

#Creation de la db
wp db create;

# choisir url titre admin mdp email skipmdp
validationDBCore="0";
skipCore='';
while [ $validationDBCore != 1 ]
do
    read -p $'\e[33mVeuillez entrer \e[36m [urlDataBase] [titreDataBase] [userAdmin] [passwordAdmin] [emailAdmin]\e[0m' urlDataBase titreDataBase userAdmin passwordAdmin emailAdmin;
    read -p $'\e[33mEtes vous sure vos informations : \e[34m '${urlDataBase}$' '${titreDataBase}$' '${userAdmin}$' '${passwordAdmin}$' '${emailAdmin}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDBCore;
done
wp core install --url=$urlDataBase --title=$titreDataBase --admin_user=$userAdmin --admin_password=$passwordAdmin --admin_email=$emailAdmin

#Modifier le DocumentRoot
validationDocumentRoot='0';
while [ $validationDocumentRoot != 1 ]
do
    read -p $'\e[33mVeuillez entrer la passerelle \e[36m [1]\e[33m /var/www/html :\e[36m [cheminPasserelle] \e[0m' cheminPasserelle;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${cheminPasserelle}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDocumentRoot;
done

if [ $cheminPasserelle = 1 ]; then #valeur par defaut 1
    cheminPasserelle="\/var\/www\/html";
    changeChemin="s/\/var\/www\/html/$cheminPasserelle/g /etc/apache2/sites-available/000-default.conf";
else #ajout du caractère d'echappement
    cheminPasserelle=$(echo $cheminPasserelle | sed -e's=\/=\\\/=g');
    changeChemin="s/\/var\/www\/html/$cheminPasserelle/g /etc/apache2/sites-available/000-default.conf";
fi

sudo sed -i -e $changeChemin;

sudo service apache2 restart

echo "Menu:";

#demander d'eteindre ou pas la vagrant
wpcliStatut="ssh";

while [ $wpcliStatut != 0 ]
do
    echo -e "${cBROWN}Que voulez vous faire ?
    1-Installation Theme
    2-Installation Plugin
    3-Installation WPCLI
    8-Suppression BDD
    9-Suppression Dossier (implique rm -rf*)
    0-Quitter (implique exit)${NC}";
    read -p "... " wpcliStatut

    #Installer Theme
    if [ $wpcliStatut = 1 ]; then
        validationTheme='0';
        while [ $validationTheme != 1 ]
        do
            read -p $'\e[33mVeuillez entrer  \e[36m [lienTheme] \e[0m :' lienTheme;
            read -p $'\e[33mEtes vous sure de votre lien : \e[34m '${lienTheme}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationTheme;
        done
        cd /wp-content/themes
        pwd
        wget $lienTheme
        echo -e "${cGREEN}Le theme à été téléchargé correctement.${NC}";
        ls
        validationTheme='0';
        while [ $validationTheme != 1 ]
        do
            read -p $'\e[33mVeuillez entrer  \e[36m [nomTheme.extension] \e[0m :' nomTheme;
            read -p $'\e[33mEtes vous sure de votre lien : \e[34m '${nomTheme}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationTheme;
        done
        unzip $nomTheme
        echo -e "${cGREEN}Le theme à été décompressé correctement.${NC}";

        validationTheme='0';
        while [ $validationTheme != 1 ]
        do
            read -p $'\e[33mVoulez vous supprimer cette archive ? Oui/Non\e[36m [1/2] \e[0m :' deleteArchive;
            read -p $'\e[33mEtes vous sure de votre lien : \e[34m '${deleteArchive}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationTheme;
        done

        #Vagrantfile Modification de la box de "base"
        if [ $deleteArchive = 1 ]; then #valeur par defaut 1
            # Verification de la presence de l'archive
            if [ ! -f $nomTheme ]; then
              rm $nomTheme;
              echo -e "${cRED}Le fichier archive a été supprimé.${NC}";
            else
                echo -e "${cRED}Vous avez entré un nom incorrect pour cette archive.${NC}";
                echo -e "${cBLUE}Suppression annulée${NC}";
            fi
        elif [ $deleteArchive = 2 ]; then #valeur par defaut 2
            echo -e "${cBLUE}Suppression annulée${NC}";
        else #ajout du caractère d'echappement
            echo -e "${cBLUE}Suppression annulée${NC}";
        fi

        cd ../..
        pwd

    #Installer Plugin
    elif [ $wpcliStatut = 2 ]; then
        validationPlugin='0';
        while [ $validationPlugin != 1 ]
        do
            read -p $'\e[33mVeuillez entrer  \e[36m [lienTheme] \e[0m :' lienPlugin;
            read -p $'\e[33mEtes vous sure de votre lien : \e[34m '${lienTheme}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationPlugin;
        done
        cd /wp-content/plugins
        pwd
        wget $lienPlugin
        echo -e "${cGREEN}Le plugin à été téléchargé correctement.${NC}";
        #unzip
        echo -e "${cGREEN}Le plugin à été décompressé correctement.${NC}";
        cd ../..
        pwd

    #Installer WPCli
    elif [ $wpcliStatut = 3 ]; then
        echo -e "${cGREEN}Installation... par defaut.${NC}";
        wp core download --locale=fr_FR
        wp config create --dbname=wordpress --dbuser=root --dbpass=root
        wp create
        wp core install --url=192.168.33.10 --title=title --admin_user=admin --admin_passord=admin --admin_email=test@test.test --skip-email

        sudo nano /etc/apache2/sites-available/000-default.conf
        sudo service apache2 restart


    #Suppression de base de donnée
    elif [ $wpcliStatut = 8 ]; then
        echo -e "${cBROWN}Veuillez taper ${NC}${cBLUE}show database ${NC}";
        echo -e "${cBROWN}Veuillez noter la table à supprimer.${NC}";
        echo -e "${cBROWN}Veuillez taper ${NC}${cBLUE}drop database [nomDeLaBase] ${NC}";
        echo -e "${cRED}Ne pas supprimer information_schema/mysql/performance_schema/sys${NC}";
        #choix bdd user mdp
        validationDBConfig="0";
        while [ $validationDBConfig != 1 ]
        do
            read -p $'\e[33mVeuillez entrer \e[36m [userDataBase] [passwordDataBase]\e[0m' userDataBase passwordDataBase;
            read -p $'\e[33mEtes vous sure vos informations : \e[34m '${userDataBase}$' '${passwordDataBase}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationDBConfig;
        done
        mysql -u$userDataBase -p$passwordDataBase;

    #Suppression de dossier
    elif [ $wpcliStatut = 9 ]; then
        #rm -rf /nomRM
        #rm -rf *
        echo -e "${cRED}Dossier supprimé${NC}";
        #Installer theme
        validationRM='0';
        while [ $validationRM != 1 ]
        do
            read -p $'\e[33mVeuillez entrer \e[36m [1]\e[33m * \e[36m [/nomDossier] \e[0m :' nomRM;
            read -p $'\e[33mEtes vous sure de votre lien : \e[34m '${nomRM}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationRM;
        done
        if [ $nomRM = 1 ]; then #valeur par defaut 1
            rm -rf *
        else #ajout du caractère d'echappement
            rm -rf $nomRM
        fi
        ls


    elif [ $wpcliStatut = 0 ]; then
      echo -e "${cRED}Fermeture SSH${NC}";
      echo -e "${cRED}Fermeture du batch...${NC}";
      exit


    else
        echo "...";
    fi
done
