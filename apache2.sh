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

echo -e "${cGREEN}Initialisation du Script... apache2.sh${NC}";
echo -e "${cBLUE}Vous etes dans `pwd` ${NC}";

#sudo apt-get install apache2;
#Installation APACHE2
read -p $'\e[33mVoulez vous installer Apache2 Oui/Non :\e[36m[1/2] \e[0m' installApache;
if [ $installApache = 1 ]; then
    sudo apt-get install apache2;
    # [DEV] modifier export APACHE RUN USER et GROUP par ubuntu
    sudo nano /etc/apache2/envvars;
    sudo services apache2 restart;
elif [ $installApache = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi

#Update
read -p $'\e[33mVoulez vous faire un update Oui/Non :\e[36m[1/2] \e[0m' installUpdate;
if [ $installUpdate = 1 ]; then
    sudo apt-get update;
    echo -e "${cGREEN}Update effectué.${NC}";
elif [ $installUpdate = 2 ]; then
    echo -e "${cBLUE}Update annulée${NC}";
else
    echo -e "${cBLUE}Update annulée${NC}";
fi

#sudo apt-get install php7.0;
#Installation PHP7.0
read -p $'\e[33mVoulez vous installer PHP7.0 Oui/Non :\e[36m[1/2] \e[0m' installPHP;
if [ $installPHP = 1 ]; then
    sudo apt-get install php7.0;
elif [ $installPHP = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi

#sudo apt-get install mysql-server;
#Installation PHP7.0
read -p $'\e[33mVoulez vous installer mysql-server Oui/Non :\e[36m[1/2] \e[0m' installMYSQL;
if [ $installMYSQL = 1 ]; then
    sudo apt-get install mysql-server;
elif [ $installMYSQL = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi


#mysql -uroot -proot
#Creation compte SQL
validationSQL="0";
while [ $validationSQL != 1 ]
do
    read -p $'\e[33mConfig SQL - Veuillez entrer \e[36m [1]\e[33m root/root ou \e[36m[userName] [userPassword]\e[0m' installSQLUser installSQLPassword;
    read -p $'\e[33mEtes vous sure de votre choix : \e[34m '${installSQLUser}$' '${installSQLPassword}$' \e[36m [1]\e[33m Oui \e[36m [2]\e[33m Changer : \e[0m' validationSQL;
done

if [ $installSQLUser = 1 ]; then
    mysql -uroot -proot;
else
    mysql -u$installSQLUser -p$installSQLPassword;
fi

echo -e "${cGREEN}Installation libapache2${NC}";
sudo apt-get install libapache2-mod-php7.0;

echo -e "${cGREEN}Installation php7.0-mysql${NC}";
sudo apt-get install php7.0-mysql;


sudo service apache2 restart;

#mysql -uroot -proot

#bash wpcli.sh;
read -p $'\e[33mVoulez vous installer wp-cli Oui/Non :\e[36m[1/2] \e[0m' installWPCLI;
if [ $installWPCLI = 1 ]; then
    bash wpcli.sh;
elif [ $installWPCLI = 2 ]; then
    echo -e "${cBLUE}Installation annulée${NC}";
else
    echo -e "${cBLUE}Installation annulée${NC}";
fi
