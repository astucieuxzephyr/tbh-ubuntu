# fichier .bash_aliases (est appele par le fichier .bashrc)
# ========================================
# 1 pour le gras, 0 pour le normal
VERT="\\033[1;32m"
VERTFONCE="\\033[1;2m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ROSE="\\033[1;35m"
BLEU="\\033[1;34m"
BLANC="\\033[0;02m"
BLANCLAIR="\\033[1;08m"
JAUNE="\\033[1;33m"
CYAN="\\033[1;36m"
ORANGE="\\033[38;5;214m"
MARRON="\\033[38;5;124m"
VIOLET="\\033[38;5;5m"
VERT_ON_MARRON="\\033[48;5;0;38;5;32m"
VERT_SUR_BLEU="\\033[48;5;5;38;5;10m"
CYAN_ON_MARRON="\\033[48;5;0;38;5;6m"
# Le \\033[ sert à commencer la séquence
# Le m sert à terminer la séquence
# de 40 à 47 : couleurs de background (mode limité ANSI 16 colors)
# de 30 à 37 : couleurs de foreground (mode limité ANSI 16 colors)
# 48;5;color for the background (extended mode ANSI 256 colors)
# 38;5;color for the foreground (extended mode ANSI 256 colors)
ORANGE_ON_TAN="\\033[48;5;124;38;5;202m"
RED_ON_VIOLET="\\033[48;5;124;38;5;196m"
OK="$VERT""OK""$NORMAL"
KO="$ROUGE""KO""$NORMAL"

# =====================================
#echo -e "$ORANGE_ON_TAN""Test 256 color GUI terminal""$NORMAL"
echo -e "$VERT_ON_MARRON""##### ""$ORANGE_ON_TAN""UBUNTU pour Windows 10""$VERT"" : ""$RED_ON_VIOLET""Création des alias ""$VIOLET""(~/.bash_aliases)""$VERT_ON_MARRON"" #####""$NORMAL"

# ============= ALIAS DES SITES =================
MNT="/mnt"

alias godemod7="cd ""$MNT""/c/wamp/www/Demo-D7/www"
alias godemod7theme="cd ""$MNT""/c/wamp/www/Demo-D7/www/sites/all/themes/custom/demod7"
echo -e "$VERT""==> alias ""$BLEU""godemod7 godemod7theme""$NORMAL""........""$OK"

alias gotango="cd ""$MNT""/c/wamp/www/Tango-Site/drupal/www"
alias gotangotheme="cd ""$MNT""/c/wamp/www/Tango-Site/drupal/www/themes/custom/tango_theme"
echo -e "$VERT""==> alias ""$BLEU""gotango gotangotheme""$NORMAL""........""$OK"

# ======= ALIASES POUR D8 ========

alias god8test="cd ""$MNT""/c/wamp/www/drupal8"
alias god8testtheme="cd ""$MNT""/c/wamp/www/drupal8/themes/bootstrap"
echo -e "$VERT""==> alias ""$BLEU""god8test god8testtheme""$NORMAL""........""$OK"

alias god8tutodev="cd ""$MNT""/c/wamp/www/drupal8tutodev"
alias god8tutodevtheme="cd ""$MNT""/c/wamp/www/drupal8tutodev/themes/bootstrap"
echo -e "$VERT""==> alias ""$BLEU""god8tutodev god8tutodevtheme""$NORMAL""........""$OK"

alias god8tutoprod="cd ""$MNT""/c/wamp/www/drupal8tutoprod"
alias god8tutoprodtheme="cd ""$MNT""/c/wamp/www/drupal8tutoprod/themes/bootstrap"
echo -e "$VERT""==> alias ""$BLEU""god8tutoprod god8tutoprodtheme""$NORMAL""........""$OK"


# ==============================
# Aliases generiques
alias ll='ls -lhA'
alias more='less'
alias cls='clear'
alias show='cat ~/.bashrc ~/.bash_aliases'
alias aide='cat /mnt/c/usr/local/aide_linux_console.txt'
alias editaide='vi /mnt/c/usr/local/aide_linux_console.txt'
echo -e "$VERT""==> alias ""$BLEU""aide / editaide / show / clear / ll / more ""$NORMAL""....""$OK"

alias tobin='cd /usr/local/bin/'
echo -e "$VERT""==> alias ""$BLEU""tobin""$NORMAL"" = ""$ROSE""c:/user/local/bin""$NORMAL"" .............""$OK"

# Aliases des dossiers des serveurs Web (WAMP, WTserver)
alias www='cd /mnt/c/wamp/www/'
alias WWW='cd /mnt/c/WTServer/WWW/'
echo -e "$VERT""==> alias ""$BLEU""www""$NORMAL"" = ""$ROSE""/mnt/c/wamp/www""$NORMAL"" .............""$OK"
echo -e "$VERT""==> alias ""$BLEU""WWW""$NORMAL"" = ""$ROSE""/mnt/c/WTServer/WWW""$NORMAL"" .............""$OK"

# Aliases des variables d'environnement
echo -e "$VERT""==> alias ""$BLEU""vars ""$NORMAL""(affiche vars environnement)........""$OK"
alias vars="echo \$PATH | tr : \\\\n"

# Fonction permettant de facilier la gestion de LAMP
lampfunc(){
 if [ $# -eq 1 ]; then
     echo -e "$BLEU""Parametre : ""$1""$NORMAL"
 else
     echo -e "$ROUGE""Veuillez indiquer le paramètre on/off""$NORMAL"
 fi

 if [ $# -eq 1 -a $1 = "on" ]; then
     echo -e "$VERT""==> lamp on : Allumage des services MySql et Apache2""$NORMAL"
     service mysql restart
     service apache2 restart
 elif [ $# -eq 1 -a $1 = "off" ]; then
     echo -e "$ROUGE""==> lamp off : Extinction des services Apache2 et MySQL""$NORMAL"
     service apache2 stop
     service mysql stop 
 else
     echo -e "$BLEU""==> Statut des services LAMP (MySQL / Apache2) :""$NORMAL"
     service apache2 status
     service mysql status
 fi
}

alias lamp='lampfunc'
echo -e "$VERT""==> alias ""$BLEU""lamp [on/off]""$NORMAL"": Services LAMP (Apache2 + Mysql)""$NORMAL""....""$OK"
alias golamp='service mysql start ; service apache2 start'
echo -e "Il est possible de lancer Apache en faisant ""$ROSE""service mysql (re)start""$NORMAL"" puis ""$ROSE""service apache2 (re)start""$NORMAL"

echo -e "$VERT""==> alias ""$BLEU""gologsapache / gla""$NORMAL"" : Aller au dossier des logs apache2""$NORMAL"
alias gologsapache='cd /var/log/apache2'
alias gla='cd /var/log/apache2'
echo -e "$VERT""==> commande ""$BLEU""vlogs ""$NORMAL""(Permet de voir les logs des projets)........""$OK"

# Function to see the logs of a specifical project
vlogs(){

 # =========================================
 # BIEN RENSEIGNER LES PARAMETRES CI DESSOUS
 # -----------------------------------------
 
 # Nom des projets existants :
 NOMS_PROJETS=( "oknosite" "test" "ptkamongo" "Sf3projet" "SymfonyMicro")
 
 # Dossier où se trouvent les fichiers de logs à afficher
 DOSSIER_LOGS_APACHE="/var/log/apache2"

 # =========================================

 if [ "$#" -eq 1 ]; then
    
    # echo -e "$BLEU""Parametre fourni : ""$JAUNE""$1""$BLEU"".....(""$VERT""OK""$BLEU"")""$NORMAL"
    
    # Ci-dessous mettre les differentes valeurs des noms de projets
    stop=0
    for param in ${NOMS_PROJETS[@]} 
    do
       if [ "$stop" -eq 0 -a "$1" = "$param" ]; then
          
          stop=1
          nomfichierlogs="$DOSSIER_LOGS_APACHE""/""$1""_error.log"
          if [ -f "$nomfichierlogs" ]; then
            echo -e "$VERT_SUR_BLEU""==> Logs du projet ""$1""$JAUNE"" (""$nomfichierlogs"") :""$NORMAL"
            tail -10 "$nomfichierlogs"
          else
            echo -e "$ROUGE""ERREUR : ""$JAUNE""Le fichier de logs ""$ROUGE""$nomfichierlogs""$JAUNE"" n existe pas !""$NORMAL"
          fi
          
       # else
          # echo -e "$BLEU""Test sur le nom de projet : ""$VERTFONCE""$param"".........""$ROUGE""KO""$NORMAL"
       fi
       # Condition du for : on continue si le stop vaut toujours zero, sinon on quitte le for
       [[ "$stop" = 0 ]] || break
    done

    if [ "$stop" -eq 0 ]; then
       echo -e "$ROUGE""==> Le nom du projet fourni en argument (""$1"") est incorrect !""$NORMAL"
       echo -e "$BLEU""  |   Les noms de projets possibles sont : ""$NORMAL"
       echo -e "$VERT""  |   ${NOMS_PROJETS[@]}""$NORMAL"
       echo -e "$ROSE""  |   Pour ajouter un projet, editez le fichier ~/.bash_aliases""$NORMAL"
    fi

 else
     echo -e "$ROUGE""Veuillez ajouter un paramètre (nom du projet)""$NORMAL"
     echo -e "$BLEU""==> Paramètre(s) possible(s) : ""$JAUNE""${NOMS_PROJETS[@]}""$NORMAL"
 fi
}

# See NPM directory
seenpmfunc(){
echo -e "$JAUNE""Modules NPM (global) : ""$ROSE""$NPM_GLOBAL_DIR""$NORMAL"" : "
ls -al $NPM_GLOBAL_DIR
}

NPM_GLOBAL_DIR="/mnt/c/Users/Tanguy/AppData/Roaming/npm/node_modules"
alias seenpm=seenpmfunc
echo -e "$VERT""==> alias ""$BLEU""seenpm""$NORMAL"" = ""$ROSE""ll /mnt/c/Users/Tanguy/AppData/Roaming/npm/node_modules""$NORMAL"" .............""$OK"

#alias charge='cd; . charge_bdd.sh' # EVITER
echo -e "$VERT""==> alias ""$BLEU""charge""$NORMAL"" : Chargeur de dump pour le MySQL (sur Ubuntu)""$NORMAL""....""$OK"
alias charge='. ~/charge_bdd_linux.sh'
alias editcharge='vi ~/charge_bdd_linux.sh'


echo -e "$VERT""==> alias editconfigapache""$NORMAL"" : Edite la conf Apache2 avec vi"
alias editconfigapache='vi /etc/apache2/sites-enabled/000-default.conf'

##### DRUPAL CONSOLE (D8) #####
# alias pour drupal console (necessite que drupal console soit installee)
alias dcr='drupal cache:rebuild'
alias dcra='drupal cache:rebuild all'


