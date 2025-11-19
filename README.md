Ce projet a pour objectif de créer un script Shell capable d’extraire automatiquement les données météorologiques d’une ville donnée. 
Le script interroge le service wttr.in, récupère la météo du jour ainsi que la prévision du lendemain, puis enregistre ces informations dans un fichier de manière lisible. 
Des fonctionnalités supplémentaires ont été ajoutées dans les versions suivantes, comme l’automatisation de l’exécution avec cron, 
ou encore la création d’un historique quotidien des données météo. 
#Voici le mode d'emploi du script 
#v1.0 
L’objectif de ce script est de récupérer la température actuelle d’une ville ainsi que la température prévue pour le lendemain.
 Pour exécuter le programme, l’utilisateur doit taper dans le terminal : ./Extracteur_Meteo.sh <nom_de_la_ville>.
Si aucune ville n’est fournie, le script affiche un message d’erreur rappelant la bonne méthode d’utilisation. 
Lors du lancement, un fichier meteo.txt est créé s’il n’existe pas encore, et à chaque exécution une nouvelle ligne y est ajoutée.
Cette ligne contient la date, l’heure, le nom de la ville, la température actuelle et la prévision du lendemain.
Pour consulter ce fichier, il suffit d’utiliser la commande cat meteo.txt.
Pour obtenir les données météorologiques, le script utilise la commande curl pour récupérer les informations brutes depuis le service wttr.in. 
Les commandes grep permettent d’extraire uniquement les valeurs nécessaires, qui sont stockées dans deux variables : TEMP_ACTUELLE et TEMP_DEMAIN.
La date et l’heure sont récupérées grâce à la commande Date, puis intégrées dans une chaîne de caractères correctement formatés.
Enfin, toutes les informations sont enregistrées de manière lisible dans le fichier meteo.txt. 
#v2.0 
Configurer une tâche cron pour automatiser l'exécution du script et enregistrer les données périodiquement  Le cron est une commande qui permet à l'utilisateur d'exécuter un script ou commande sur un intervalle de temps ou à une date fixe.
Pour programmer l'intervalle de l'exécution de la commande, il faut utiliser le format ci-dessous : 
crontab -option ***** /chemin/vers/script.sh 
Chaque étoile représente une unité pour mesurer le temps, de gauche à droite : minute, heure, jour du mois, mois, jour de la semaine.
Pour le configurer il faut le faire sur Ubuntu car git bash ne peut pas faire l’automatisation avec cron. 
Une fois dans Ubuntu il faudra savoir où se trouve le projet : 
c/Users/PC/Outil_Extracteur_Meteo/Extracteur_Meteo.sh 
Ensuite il faut créer un dossier pour copier le fichier dans Ubuntu : 
mkdir -p ~/meteo 
cd ~/meteo 
Copiez le script depuis le dépôt windows Outil_Extracteur_Meteo dans le dossier meteo Linux où le script sera exécuté 
cp /mnt/c/Users/PC/Outil_Extracteur_Meteo/Extracteur_Meteo.sh ~/meteo/ 
Rendre le script exécutable 
chmod +x ~/meteo/Extracteur_Meteo.sh 
Pour configurer la tâche cron il faut ouvrir le crontab avec la commande crontab -e, choisir l'éditeur nano et écrire cette ligne de commande : 
0 * * * * /home/diallo/meteo/Extracteur_Meteo.sh >> /home/diallo/meteo/extraction.log 2>&1 Ceci (/home/diallo/meteo/Extracteur_Meteo.sh) est le chemin complet du script. 
Ensuite il faut vérifier que cron est actif et qu’il fonctionne : 
sudo service cron status 
Pour tester que le cron a marché il faut utiliser la commande : 
cat ~/meteo/extraction.log on devrait voir la sortie du script ajoutée au log 
Note : GitHub ne lance pas le cron. Le professeur ou toute autre personne devra configurer le cron sur son propre système Linux pour que l’automatisation fonctionne. 
#v3.0 
Dans cette version, une nouvelle fonctionnalité est ajoutée pour permettre la gestion d'un historique des données météo. 
L’objectif est de conserver les prévisions collectées chaque jour dans des fichiers séparés afin de pouvoir suivre l’évolution des températures dans le temps. 
Une option supplémentaire appelée --archive est introduite. 
Lorsque cette option est utilisée lors de l’exécution du script, celui-ci active le mode archivage ./Extracteur_Meteo.sh Toulouse --archive. 
Le script récupère d'abord la date du jour à l'aide de la commande date, puis forme cette date sous la forme YYYYMMDD.
Cette date est ensuite utilisée pour créer un nom de fichier unique pour la journée, par exemple : cat meteo_20251118.txt .
À chaque exécution du script avec l’option --archive, les données météo collectées (date, heure, ville, température actuelle, température du lendemain) 
sont ajoutées à ce fichier du jour. 
Si le fichier de la journée n’existe pas encore, il est automatiquement créé. 
S’il existe déjà, l’exécution du script ajoute simplement une nouvelle ligne à la suite des précédentes valeurs. 
#varainte 1
Les variantes 1 et 2  vont juste rajouter des éléments supplémentaires sur le script mais l'exécution reste la même. 
La variante 1 permet de rajouter à l'extraction des températures actuelles et demain la vitesse du vent et la visibilité. 
La variante 2 permet d’ajouter une option de sauvegarde sous format JSON.

