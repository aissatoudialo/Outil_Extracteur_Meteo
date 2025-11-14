# Outil_Extracteur_Meteo
Le script Extracteur_Meteo.sh est automatisé avec cron pour s’exécuter automatiquement.

Pour configurer l’exécution toutes les heures, la ligne suivante est ajoutée au crontab de l’utilisateur :

0 * * * * /home/diallo/meteo/Extracteur_Meteo.sh >> /home/diallo/meteo/extraction.log 2>&1

Cette commande lance le script à chaque heure pile.

Les sorties et erreurs sont enregistrées dans extraction.log.

Pour consulter les résultats, lire le fichier de log :
cat ~/meteo/extraction.log

Note : GitHub ne lance pas le cron. 
Le professeur ou toute autre personne devra configurer le cron sur son propre système Linux pour que l’automatisation fonctionne.
