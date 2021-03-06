#!/bin/bash
########### Autor: Ernesto Sequeira ##################################
########### Imagenes: tareas sobre archivos ##########################

# Colors constants
NONE="$(tput sgr0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="\n$(tput setaf 3)"
BLUE="\n$(tput setaf 4)"

# Path constant
DIRECTORY="/cygdrive/z/TMSShares/Multimedia/COLECCION/"

message_date() {
        # $1 : Message
        # $2 : Color
        # return : Message colorized
        local NOW="[$(date +%H:%M:%S)]"
        echo -e "${2}${NOW}${1}${NONE}"
}

message() {
        # $1 : Message
        # $2 : Color
        # return : Message colorized
        echo -e "${2}${1}${NONE}"
}

### Menú principal ###
main_menu() {
        clear
        while [ "$option" != 0 ]
        do
                echo " Main Menu: "
                echo " -----------"
                echo "[1]. Delete Files."
                echo "[2]. Rename Files."
                echo "[3]. Move Files."
                echo "[4]. Export Files."
                echo "[5]. Create Directory."
                echo "[6]. Exit"
                read -p "Select an option [1-6]: " option
        case $option in
                1) deleteFiles $DIRECTORY;;
                2) renameFiles $DIRECTORY;;
                3) moveFiles $DIRECTORY;;
                4) exportFiles $DIRECTORY;;
                5) createDirectory $DIRECTORY;;
                6) exit 0;;
                *) echo "$option is an invalid option.";
                echo "Press any key to finish continue...";
                read foo;;
        esac
        done
}

### Eliminar todos los archivos con la extension indicada ###
function deleteFiles(){
        echo "Input the file extension: (example: DS_Store)"
        read ext

        for ((i=1; i<12201; i=i+100))
        do
                z=$(($i+99))
                find $1/$i"-"$z -type f -name *.$ext -exec rm -rf {} +
        done

        message_date ">> Complete task." ${GREEN}
        echo "Press any key to finish..."
        read p
        clear
}

### Renombrar recursivamente todos los archivos de directorios con la fecha de modificación
function renameFiles(){
	# Reemplazar espacios vacios por guion bajo
        find $1 -depth -name '* *' | while IFS= read -r f ; do mv -i "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done

        for FILE in $(find $1 -type f -name "*.*")
        do
                nombre=$(basename $FILE)
                ruta=$(dirname $FILE)
                fecha=$(stat $FILE | grep "Modi")
                fecha_modificacion=$(echo $fecha | cut -d " " -f 2)
                nombre_sin_extension=$(sed -r 's#.*/(.*)\.([^\.]+)#\1#' <<< $FILE)
                extension=$(awk -F\. '{print $NF}' <<< $nombre)
                mv $FILE $ruta"/"$nombre_sin_extension"."$fecha_modificacion"."$extension
        done

        message_date ">> Complete task." ${GREEN}
        echo "Press any key to finish..."
        read p
        clear
}

### Mover archivos a su respectivos directorios raices ###
function moveFiles(){
        for ((i=1; i<12201; i=i+100))
        do
                z=$(($i+99))
                find $1/$i"-"$z -type f -name "*.*" -exec mv -t $1/$i"-"$z {} +
        done
}

### Exportar la ruta del archivo y su nombre en columnas diferentes a un archivo .csv
function exportFiles(){

        for FILE in $(find $1 -type f -name "*.*")
        do
                nombre=$(basename $FILE)
                ruta=$(dirname $FILE)

                echo $ruta";"$nombre >> target.csv
        done

        message_date ">> Complete task." ${GREEN}
        echo "Press any key to finish..."
        read p
        clear
}

### Crear indice de directorios raices ###
function createDirectory(){
        for ((i=1; i<12201; i=i+100))
        do
                z=$(($i+99))
                mkdir $1/$i"-"$z {} +
        done
}

### Call funtion ###
main_menu
