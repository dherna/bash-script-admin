#!/bin/bash
#
# Detalles: Este script está pensado para actualizar los repositoros de un mismo servidor.
#           
# Variables de centros
CENTROS="centro1 centro2"
#
# Menu aplicar repositorio
#
clear
while [ "$opcion" != 3 ]
# Opciones modulo sallenet, core
do
         echo " Escoja una opcion "
         echo "1. Actualiza todos los dominos"
         echo "2. Actualizar dominio individual"
         echo "3. Salir"
         read -p "Seleccione una opcion [1 - 3]" opcion

         case $opcion in
                1) echo "Vamos a actualizar Modulo"

                        cd /home/repositorio/moodle/mod
                        sudo -u repositorio git pull

                        #movi
                        for centro in $CENTROS; do
                                mv /var/www/$centro/httpdocs/mod/modulo /var/www/$centro/httpdocs/mod/modulo-old
                                cp -r /home/repositorio/moodle/mod/modulo /var/www/$centro/httpdocs/mod/
                                chown -R www-data:www-data /var/www/$centro/httpdocs/mod/modulo
                                rm -Rf /var/www/$centro/httpdocs/mod/modulo-old
                        done;;
                        #rsync

                2)  echo "Estos son mis dominios"
                        echo ""
                        ls -lrtA1 /var/www/ | awk '/^[d]/' |awk '{print($9)}'
                        read -r -p "Amo, qué dominio debo actualizar?: " dominus
                        mv /var/www/$dominus/httpdocs/mod/modulo /var/www/$dominus/httpdocs/mod/modulo-old
                        cp -r /home/repositorio/moodle/mod/modulo /var/www/$dominus/httpdocs/mod/
                        chown -R www-data:www-data /var/www/$dominus/httpdocs/mod/modulo
                        rm -Rf /var/www/$dominus/httpdocs/mod/modulo-old;;

                 3) exit 0;;
                 *) echo "$opc es una opcion invalida.";
                  echo "Presiona una tecla para continuar...";
          read foo;;
        esac
done


# Menu centro a aplicar cambios


# actualizar Corre
