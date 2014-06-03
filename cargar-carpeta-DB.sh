#!/user/bin
#
# Detalles: Este script está pensado para tratar las base de datos que tienes en 
#           una carpeta y cargarlas a un servidor de MySQL
#
#
# CONEXION DB
MYSQLUSER="root"
MYSQLPASS='estaesmicontraseña'
MYSQLHOST="localhost"

# LISTADO DE CARPETA TEMPORAL Y VARIABLILIZARLO
DBS="echo `ls`"


for db in $DBS
do
        echo "Descomprimiendo $db"
        gzip -d $db
        if [ "$?" -ne "0" ]; then 
                 echo "########## Error en Descompresióni $db - Date: $(date) "
        else
                NAMEDB="${db#*.es_mysql_}"
                echo "$NAMEDB"
                NAMEDBF="${NAMEDB%.gz*}"
                echo "Creando MySQL moodle1_$NAMEDBF"
                mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS -e 'DROP DATABASE moodle1_'$NAMEDBF';'
                echo "CREATE DATABASE  $NAMEDBF"
                mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS -e 'CREATE DATABASE moodle1_'$NAMEDBF';'
                if [ "$?" -ne "0" ]; then
                        echo "########## Error Al crear la Base de Datos moodle1_'$NAMEDBF - Date: $(date) "
                else
                        echo "SOURCE $db"
                        mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS moodle1_$NAMEDBF -e 'SOURCE '$db';'
                        if [ "$?" -ne "0" ]; then
                                echo "########## Error al cargar la Base de Datos moodle1_'$NAMEDBF - Date: $(date) "
                        else
                                echo "Termino de cargar, borrando fichero,  pasamos al siguiente."
                                rm $db
done
