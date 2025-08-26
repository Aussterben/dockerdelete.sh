#!/bin/bash

##############################################
#            Script By Aussterben            #
##############################################

# Recuerda dar permisos de ejecución con "chmod +x dockerdelete"

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

if [ "$(whoami)" != "root" ]; then
    echo -e "\n${redColour}[!]${endColour}${grayColour} Esta herramienta debe de ser ejecutada como ROOT${endColour}\n"; exit 1
fi

# ctrl_c
function ctrl_c(){
  echo -e "\n${yellowColour}[!]${endColour}${redColour} Saliendo...${endColour}\n"
  tput cnorm; exit 1
}

# Llama a la función "ctrl_c"
trap ctrl_c INT

tput civis
echo -e "\n${yellowColour}[+]${endColour}${grayColour} Borrando contenedores e imágenes${endColour}${blueColour} Docker${endColour}\n"
sleep 0.5

# Ejecutar y guardar código de estado
docker rm $(docker ps -a -q) --force 2>/dev/null
status_rm=$?

docker rmi $(docker images -q) --force 2>/dev/null 
status_rmi=$?

if [[ $status_rm -eq 0 && $status_rmi -eq 0 ]]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Los archivos${blueColour} docker${endColour}${grayColour} han sido borrados con éxito${endColour}\n"
else
    echo -e "\n${redColour}[x]${endColour}${grayColour} Ha ocurrido un error al intentar borrar contenedores o imágenes Docker${endColour}\n"
fi

tput cnorm

