#!/bin/bash

if [ -z "$1" ]; then
	
    echo "Usage: $0 <ville>"
    echo "Ville mise par défaut : Toulouse"
    set -- "Toulouse"
fi

if ! [[ "$1" =~ ^[A-Za-z]+$ ]]; then
	echo "Erreur : n'est pas une chaîne de caractères."
    echo "Usage : $0 <ville>"
	exit 1
fi

if [ $# -gt 2 ]; then
        echo "Erreur : trop d'arguments."
    echo "Usage : $0 <ville> [--archive]"
        exit 1
fi

OPTION=$2


VILLE=$1
FICHIER="meteo_brut.txt"

#<<<<<<< HEAD
curl -s "https://wttr.in/$VILLE" | sed 's/\x1B\[[0-9;]*m//g' > "$FICHIER"
#=======
curl -s "https://wttr.in/$VILLE" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g' > "$FICHIER"
#>>>>>>> version1_2question

if [ ! -s "$FICHIER" ]; then
    echo "Erreur : impossible de récupérer les données météo."
    exit 1
fi

#=======
TEMP_ACTUELLE=$(grep -o '[+-]\?[0-9]\{1,2\}' "$FICHIER" | head -n 1)
JOUR_DEMAIN=$(grep -E '┤  [A-Z][a-z]{2} ' "$FICHIER" | sed -n '2p')
LN=$(grep -n -F "$JOUR_DEMAIN" "$FICHIER" | cut -d: -f1)
TEMP_DEMAIN="N/A"

if [ -n "$LN" ]; then
  TEMP_DEMAIN=$(sed -n "$((LN+1)),$((LN+10))p" "$FICHIER" | grep -o '+[0-9]\+' | head -n1)
fi
echo "Données météo enregistrées dans $FICHIER"
echo "Température actuelle : ${TEMP_ACTUELLE}°C"
echo "Prévision demain : ${TEMP_DEMAIN}°C"
#version 1 question 3 et 4
DATE=$(date '+%Y-%m-%d - %H:%M')
LIGNE="$DATE - $VILLE : ${TEMP_ACTUELLE}°C - ${TEMP_DEMAIN}°C"

echo "$LIGNE" >> meteo.txt

if [ "$OPTION" == "--archive" ]; then
    JOUR=$(date '+%Y%m%d')
    FICHIER_HISTO="meteo_${JOUR}.txt"
    echo "$LIGNE" >> "$FICHIER_HISTO"
fi
