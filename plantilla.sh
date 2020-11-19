#!/bin/bash
#
#  Programa: plantilla.bsh
#
#  Parametros:
#              $1   -  n/a
#
#  Salida:
#              1    -  Error de parametros
#
#  Descripcion:
#
#    Shell Script para xxxxxxxxx, describir la funcion de este script
#
# Versiones      Fecha        Programador, Modificacion
# -----------    ----------   -------------------------------------------
# Version=1.00   08/07/2013 - Carlos Ijalba, Original.
# Version=1.02   23/10/2015 - Carlos Ijalba, Reemplazado echos por "echo -e".
# Version=1.03   24/04/2018 - Carlos Ijalba, Añadido basename en $PROGRAMA.
  Version=1.04 # 19/11/2020 - Carlos Ijalba, Añadido return & exit to if_error funtion. 
#
#########################################################################

#Debug                                Parametros para Depurar codigo ####

# set -x


#Var                                        Declaracion de Variables ####

PROGRAMA=$(basename $0)                 # declarar las variables de nuestros scripts
TEMP=/tmp/file                          # siempre en MAYUSCULAS, para poder identificarlas
                                        # facilmente dentro del codigo
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
ENDC="\033[m"


#Function                                                 Funciones #####

function usage
 ######################
 #
 # funcion para mostrar la pantalla de ayuda del script (usage).
 #
 ######################
{
cat << EOF

$PROGRAMA   ver: $Version

Uso:
     $PROGRAMA [parametro1]

Ejemplo:  $PROGRAMA  1parametro

EOF
}


function if_error
 ######################
 #
 # funcion para tratar errores despues de la ejecucion de un comando,
 # se invoca de la siguiente manera:
 #
 #    funcion         $1              $2              $3
 #    -------- -------------------  ------  ------------------------
 #    if_error "Fallo de operacion" ACTION  "Funciono correctamente"
 #
 # Nota: ACTION ($2) es la accion a tomar cuando la operacion anterior ha fallado, esta puede ser "exit" o "return", dependiendo
 # de si queremos que con un error el programa aborte con el msg de error y el RC o que solamente de el msg de error y siga su
 # ejecucion.
 #
 ######################
{
if [ $? -ne 0 ]
  then                                  # comprobar el ultimo return code, si rc <> 0...
    echo -e "$RED--- ERROR: $ENDC$1\n"  # ...imprimir msg y devolver el rc original.
    $2 $?
  else                                  # si fue OK, imprimir msg satisfactorio.
    echo -e "$GREEN+++ OK: $ENDC$3"
fi
}

#Usage                                         Mostrar uso y version ####

                                        # Si ejecutamos el script sin los parametros correctos...
if [ $# -eq 0 ]                         # ...mostrar el uso correcto y version del programa.
  then
    usage
    exit 1
fi


#Begin Main                                         Proceso Principal ####

echo -e "\n O-> $PROGRAMA v$Version - Plantilla para programas bash shell.\n"

rm $TEMP > /dev/null 2>&1
if_error "Fallo al intentar borrar fichero $TEMP." return "Borrado fichero $TEMP."

echo -e "\n o-> $PROGRAMA Finished.\n"     # msg final

#End Main                                             Fin de Programa ####
