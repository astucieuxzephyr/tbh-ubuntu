#!/bin/bash
# Author : Tanguy Bodin-Hullin <tanguybh2@hotmail.com>
# Last version : 05 oct 2017
# Ce script permet de charger un fichier de dump dans une base de données MySQL
# après affichage d'un message de confirmation
# Avant le chargement, le script effectue une sauvegarde automatique de la base courante

NOCOLOR="\\033[0;39m"
ORANGE="\\033[38;5;214m"
JAUNE="\\033[1;33m"
MYSQL_ERREUR=0

# Functions
red() { echo -e '\e[31m'$1'\e[m'; } # Red
green() { echo -e '\e[32m'$1'\e[m'; } # Green
yellow() { echo -e '\e[33m'$1'\e[m'; } # Yellow
blue() { echo -e '\e[34m'$1'\e[m'; } # Blue
cyan() { echo -e '\e[36m'$1'\e[m'; } # Cyan
orange() { echo -e '\e[38;5;214m'$1'\e[m'; } # Orange

savedatabase() {
    read -p "Voulez-vous faire une sauvegarde de votre base actuelle ? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[YyOo]$ ]]
    then
            # Initialisation du chemin du dossier de sauvegarde de la base
        # Répertoire de stockage des sauvegardes
CHEMIN_DOSSIER_PROJET="$CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET"
        CHEMIN_BACKUP_BASES="$CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET/backups_mysql"
        # On vérifie que ce dossier existe, et si ce n'est pas le cas on le crée
if [ -d "$CHEMIN_DOSSIER_PROJET" ]; then 
green "Le dossier du projet existe ($CHEMIN_DOSSIER_PROJET) : OK"
if [ -d "$CHEMIN_BACKUP_BASES" ]; then 
    green "Le dossier conteneur des sauvegardes est $CHEMIN_BACKUP_BASES" 
else 
orange "Le dossier de backup $CHEMIN_BACKUP_BASES n'existe pas :"
yellow "=> Creation du dossier des sauvegardes $CHEMIN_BACKUP_BASES"
mkdir $CHEMIN_BACKUP_BASES
fi
else
orange "Le dossier du projet $CHEMIN_DOSSIER_PROJET n'existe pas :"
read -p "Voulez-vous creer ce dossier malgre tout ? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[YyOo]$ ]]
then
yellow "=> Creation d'un dossier Projet $CHEMIN_DOSSIER_PROJET"
mkdir $CHEMIN_DOSSIER_PROJET
# le dossier a été créé, on regarde si c'est bon pour le dossier suivant
if [ -d "$CHEMIN_BACKUP_BASES" ]; then 
   green "Le dossier conteneur des sauvegardes est $CHEMIN_BACKUP_BASES" 
else 
orange "Le dossier de backup $CHEMIN_BACKUP_BASES n'existe pas :"
yellow "=> Creation du dossier des sauvegardes $CHEMIN_BACKUP_BASES"
mkdir $CHEMIN_BACKUP_BASES
fi
else
orange "Vous pouvez editer $THIS_SCRIPT pour modifier les parametres du projet (nom bdd, etc), et relancer la commande charge."
return
fi
fi

        # Nom de la sauvegarde
        BACKUP_DUMP_NAME="dump_$1_$(date +%d.%m.%y@%Hh%M)"
        # Compression
            COMPRESSIONCMD="tar -czf" 
            COMPRESSIONEXT=".tar.gz"
        yellow "=> Creation du BACKUP : Dump de la base $NOM_BDD"
            yellow "     vers : $CHEMIN_BACKUP_BASES/$BACKUP_DUMP_NAME$COMPRESSIONEXT"
        mysqldump $IDENTIFICATION_MYSQL  --quick --add-locks --lock-tables --extended-insert $NOM_BDD  > ${CHEMIN_BACKUP_BASES}/${BACKUP_DUMP_NAME}.sql
        yellow "=> Compression du backup..."
        # On compresse avec tar
            cd ${CHEMIN_BACKUP_BASES}
            ${COMPRESSIONCMD} ${BACKUP_DUMP_NAME}${COMPRESSIONEXT} ${BACKUP_DUMP_NAME}.sql
        # On supprime le fichier sql non compressé
        rm -f ${BACKUP_DUMP_NAME}.sql
            #chmod 600 ${DATANAME}${COMPRESSIONEXT}
green "Done !!"
green "Pour rappel ce nom de base $NOM_BDD doit etre celui indiqué dans votre default/settings.local.php"
    fi
}

# ########## PARAMETRAGES GENERAUX #####################
mysql_user=root
mysql_pass=""
mysql_host="localhost"

IDENTIFICATION_MYSQL=" -u $mysql_user "
# Si on a besoin d'utiliser un mot de passe
# IDENTIFICATION_MYSQL=" -u $mysql_user -p $mysql_pass "
# IDENTIFICATION_MYSQL=" -u $mysql_user -p $mysql_pass -h $mysql_host "
currentPath=$PWD
# cyan $currentPath
execPath=$(readlink -f $(dirname $0))
THIS_SCRIPT="$execPath/charge_bdd_linux.sh"
CHEMIN_DOSSIER_CONTENEUR_PROJETS="/mnt/c/Users/Eurelis/Documents/Tanguy"

# ########## PARAMETRAGES SPECIFIQUES #####################
# Ces paramètres sont à changer à chaque fois que l'on change de projet
# ATTENTION : Eviter les tirets du 6 dans le nom de la BDD ! (sinon le script ne fonctionne pas bien) 
# Ci-dessous : Modèle des 4 variables à initialiser :
# NOM_BDD="bdd_de_monprojet"
# NOM_DOSSIER_PROJET="_Mon-Dossier-Projet"
# NOM_FICHIER_DUMP_SQL="monprojet.sql"
# PREFIXE_SAUVEGARDE="monprojet" <== Ce préfixe peut être vide

# Le script sauvegardera le dump automatiquement dans le dossier _Mon-Dossier-Projet/backups_mysql/
# sous le nom : dump_{PREFIXE_SAUVEGARDE}_JJ.MM.AA@HHhmm.tar.gz
# Par exemple dump_monprojet_05.10.17@17h54.tar.gz
# ########## CI-DESSOUS DECOMMENTER LES 4 LIGNES DU PROJET QUE VOUS VOULEZ UTILISER ########

NOM_BDD="bdd_de_monprojet"
NOM_DOSSIER_PROJET="_Mon-Dossier-Projet"
NOM_FICHIER_DUMP_SQL="monprojet.sql"
PREFIXE_SAUVEGARDE="monprojet"

# NOM_BDD="d8tuto_prod"
# NOM_DOSSIER_PROJET="_D8Tuto-Prod"
# NOM_FICHIER_DUMP_SQL="d8tuto_prod_ori.sql"
# PREFIXE_SAUVEGARDE="d8tutoprod"

# NOM_BDD="d8tuto_dev"
# NOM_DOSSIER_PROJET="_D8Tuto-Dev"
# NOM_FICHIER_DUMP_SQL="d8tuto_dev_ori.sql"
# PREFIXE_SAUVEGARDE="d8tutodev"

# NOM_BDD="d8test"
# NOM_DOSSIER_PROJET="_D8Test"
# NOM_FICHIER_DUMP_SQL="d8test_ori.sql"
# PREFIXE_SAUVEGARDE="d8test"

# ########## A PARTIR D'ICI NE PAS TOUCHER ###################

# Vérifie que le service mysql est lancé
MYSQL_UP=$(pgrep mysql | wc -l);
if [ "$MYSQL_UP" -eq 0 ];
then
        red "MySQL is down.";
        yellow "Starting MySQL service..."
        sudo service mysql start
        green "MySQL Service started."
else
	green "MySQL Service is started."
fi


# TODO Vérifie que le dossier projet existe
# TODO : Vérifie que le fichier de dump existe.
# S'il n'existe pas et que la version compressée gz existe on décompresse !!

blue "## [$THIS_SCRIPT] ##"
cyan "Configuration actuelle : ""$JAUNE""$NOM_DOSSIER_PROJET"
cyan "Vous souhaitez importer le dump (dump des tables)"
yellow "$CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET/$NOM_FICHIER_DUMP_SQL"
cyan "Vers la base : ""$JAUNE""$NOM_BDD"

read -p "Avant de lancer le script, confirmez-vous les informations ci-dessus ? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[YyOo]$ ]]
then
# On regarde si la base existe
if ! mysql $IDENTIFICATION_MYSQL -e "use $NOM_BDD"; then
   #Si la base n'existe pas, on la crée
   orange "The database $NOM_BDD does not exist :"
   yellow "=> Creation of database $NOM_BDD..."
   if ! mysql $IDENTIFICATION_MYSQL -e "create database if not exists $NOM_BDD;"; then
   red "Error : Please Check that your MySQL / WAMP Server is ON"
   MYSQL_ERREUR=1
   fi
   # TODO
   # pause
   # exit
else
   # Si la base existe on crée une sauvegarde automatiquement, puis on vide les tables
    green "The database $NOM_BDD does exist !"
savedatabase $PREFIXE_SAUVEGARDE

###

    # Quelle que soit la réponse à la demande de sauvegarde,
# On vide les tables de la base existante avec une fonction spécifique
    yellow "=> Deleting all tables ..."
mysqldump $IDENTIFICATION_MYSQL --add-drop-table --no-data $NOM_BDD | grep ^DROP | mysql $IDENTIFICATION_MYSQL $NOM_BDD
   
    # Autre méthode pour obtenir une base vide, inutile sauf si souci avec la première
    #mysqldump -u $mysql_user --add-drop-database --add-drop-table --no-data $NOM_BDD  > basevide.sql
    #mysql -u $mysql_user $NOM_BDD < basevide.sql
    #rm -f ${CHEMIN_BACKUP_BASES}/basevide.sql
fi

if [ $MYSQL_ERREUR -ne 1 ]; then

if [ -f $CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET/$NOM_FICHIER_DUMP_SQL ]; then
# Enfin on lance la commande
yellow "=> Filling the database with the dump data..."
yellow "please wait..."
mysql $IDENTIFICATION_MYSQL $NOM_BDD < $CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET/$NOM_FICHIER_DUMP_SQL
green "Done !!"
green "Pour rappel ce nom de base $NOM_BDD doit etre celui indiqué dans votre default/settings.local.php"
else
    #Si la base n'existe pas, on la crée
    orange "The file $CHEMIN_DOSSIER_CONTENEUR_PROJETS/$NOM_DOSSIER_PROJET/$NOM_FICHIER_DUMP_SQL does not exist !"
red "==> Please check and correct the dump filename written in this file."
fi

else
red "==> Une erreur MYSQL est apparue. Arrêt du script."
fi


else
# PROPOSITION DE SAUVER LA BASE
    savedatabase $PREFIXE_SAUVEGARDE
blue "Vous pouvez editer $THIS_SCRIPT pour modifier les parametres du projet (nom bdd, etc), et relancer la commande charge."
fi
cd "$currentPath"

