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
1. Sauvegardez l'ancien fichier .bashrc s'il existe :
   On ajoute "_ORI" à la fin du nom du fichier pour garder une trace du fichier original
    $ mv .bashrc .bashrc_ORI
2. Renommez le fichier .bashrc_off en .bashrc afin d'activer le nouveau fichier :
    $ mv .bashrc_off .bashrc
3. Relancez la console Ubuntu

## Note :
Le fichier .bashrc_profile_off sert de référence, mais normalement il n'a pas besoin d'être activé.
C'est le fichier .profile original d'Ubuntu qui appelle le fichier .bashrc
