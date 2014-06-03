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
DBS="`ls`"

for db in $DBS
do
        echo "Descomprimiendo $db"
        gzip -d $db
        if [ "$?" -ne "0" ]; then
                 echo "########## Error en Descompresióni $db - Date: $(date) "
        else   
                FILE="${db#*.es_mysql_}"
                echo "sin .es_mysql_ $FILE"
                NAMEDB="${FILE%.gz*}"
                echo "sin .es_mysql_ ni .gz $NAMEDB"
                NAMEFILE="${db%.gz*}"
                echo "sin .gz añadinedo  moodle1_ - $NAMEDB"
                mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS -e 'DROP DATABASE moodle1_'$NAMEDB';'
                echo "CREATE DATABASE  $NAMEDB"
                mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS -e 'CREATE DATABASE moodle1_'$NAMEDB';'
                if [ "$?" -ne "0" ]; then
                        echo "########## Error Al crear la Base de Datos moodle1_'$NAMEDB - Date: $(date) "
                else   
                        echo "SOURCE $NAMEFILE"
                        echo "mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS moodle1_$NAMEDB -e 'SOURCE '$NAMEFILE';'"
                        mysql -u $MYSQLUSER -h $MYSQLHOST -p$MYSQLPASS moodle1_$NAMEDB -e 'SOURCE '$NAMEFILE';'
                        if [ "$?" -ne "0" ]; then
                                echo "########## Error al cargar la Base de Datos moodle1_'$NAMEDBF - Date: $(date) "
                        else   
                                echo "Termino de cargar, borrando fichero,  pasamos al siguiente."
                                rm $db
                        fi
                fi
        fi

done
