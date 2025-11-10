#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <ville>"
    exit 1
fi

VILLE=$1
FICHIER_BRUT="meteo_brut.txt"

curl -s "https://wttr.in/$VILLE" | sed 's/\x1B\[[0-9;]*m//g' > "$FICHIER_BRUT"
echo "Donne meteo enregistree dans $FICHIER_BRUT"
