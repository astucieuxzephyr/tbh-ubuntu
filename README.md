# tbh-ubuntu
Ensemble de fichiers de configuration de base permettant de paramétrer Ubuntu sous Windows de façon opérationnelle rapidement.

## Rappels :
- Dans Ubuntu sous Windows, ces fichiers doivent se trouver dans le dossier \mnt\c\Users\NomUtilisateur\\
- Au préalable, git doit avoir été installé (commande `sudo apt-get install git`) et configuré.

## Pour récupérer ce projet sur votre PC (sous Ubuntu pour Windows) :
Lancer le bash Ubuntu, et faire :

    $ cd ~
    $ git init .
    $ git remote add -f origin https://github.com/astucieuxzephyr/tbh-ubuntu
    $ git pull origin master

## Sauvegarder et activer les nouveaux fichiers :
Sauvegardez l'ancien fichier .bashrc s'il existe :
On ajoute "_ORI" à la fin du nom du fichier pour garder une trace du fichier original
   
    $ mv .bashrc .bashrc_ORI
   
Renommez le fichier .bashrc_off en .bashrc afin d'activer le nouveau fichier :

    $ mv .bashrc_off .bashrc
   
Enfin, Relancez la console Ubuntu

## Remarques :
- Le fichier .bashrc_profile_off a été mis ici comme référence (pour un ancien système), mais normalement il n'a pas besoin d'être activé et peut même être effacé.
- C'est le fichier ~/.profile original d'Ubuntu qui appelle normalement le fichier .bashrc
- Si ~/.bash_profile est présent, Bash le charge au lieu de ~/.profile, ce qui peut empêcher l’exécution de .bashrc.
- D'où l'importance de désactiver le fichier ~/.bash_profile


