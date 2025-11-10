#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <ville>"
    exit 1
fi

VILLE=$1
FICHIER="meteo_brut.txt"

curl -s "https://wttr.in/$VILLE" | sed 's/\x1B\[[0-9;]*m//g' > "$FICHIER"

if [ ! -s "$FICHIER" ]; then
    echo "Erreur : impossible de récupérer les données météo."
    exit 1
fi

echo "Donnees meteo enregistrees dans $FICHIER"

TEMP_ACTUELLE=$(grep -o '[0-9]\+ *°C' "$FICHIER" | head -n1)
TEMP_DEMAIN=$(grep "°C" "$FICHIER" | head -n 2 | tail -n 1 | grep -o '[0-9+-]\+ *°C')

echo "Température actuelle : $TEMP_ACTUELLE"
echo "Prévision demain : $TEMP_DEMAIN"

