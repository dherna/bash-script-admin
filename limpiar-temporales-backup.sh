#!/bin/bash
#
# Detalles: Este script está pensado para borrar ficheros temporales y copias de seguridad
#           de la moodledata.
#
DOMAINS=`ls -A1 /home/`
DOMAINS_PATH=/home
DOMAINS_DATA=moodledata/
DOMAINS_WEB=public_html

echo "Procedemos a limpiar ficheros temporales y copias de seguridad..."

for domain in $DOMAINS
do
        # Limpiamos copias de seguridad
        find $DOMAINS_PATH/$domain/$DOMAINS_DATA -name "copia_de_seguridad*" -exec rm -f {} \;
        find $DOMAINS_PATH/$domain/$DOMAINS_DATA -name "còpia_ d_ seguretat*" -exec rm -f {} \;
        find $DOMAINS_PATH/$domain/$DOMAINS_DATA -name "segurtasun-kopia*" -exec rm -f {} \;
        find $DOMAINS_PATH/$domain/$DOMAINS_DATA -name "backup-*" -exec rm -f {} \;

        # Limpiamos ficheros temporales
        find $DOMAINS_PATH/ -name *~ -exec rm '{}' \;

done

echo FIN
