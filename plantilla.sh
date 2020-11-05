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
  Version=1.03 # 24/04/2018 - Carlos Ijalba, Añadido basename en $PROGRAMA.
#
#########################################################################

#Debug                                Par�metros para Depurar c�digo ####

# set -x


#Var                                        Declaraci�n de Variables ####

PROGRAMA=$(basename $0)                 # declarar las variables de nuestros scripts
TEMP=/tmp/file                          # siempre en MAYUSCULAS, para poder identificarlas
                                        # f�cilmente dentro del c�digo
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
ENDC="\033[m"


#Function                                                 Funciones #####

function usage
 ######################
 #
 # funci�n para mostrar la pantalla de ayuda del script (usage).
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
 # funci�n para tratar errores despu�s de la ejecuci�n de un comando,
 # se invoca de la siguiente manera:
 #
 #    funci�n         $1            $2          $3
 #    -------- -------------------  ---- ------------------------
 #    if_error "Fallo de operaci�n" siOK "Funcion� correctamente"
 #
 # Nota: en $2 podemos usar siOK, else, o cualquier otra palabra.
 #
 ######################
{
if [ $? -ne 0 ]
  then                                  # comprobar el �ltimo return code, si rc <> 0...
    echo -e "$RED--- ERROR: $ENDC$1\n"  # ...imprimir msg y devolver el rc original.
    exit $?
  else                                  # si fu� OK, imprimir msg satisfactorio.
    echo -e "$GREEN+++ OK: $ENDC$3"
fi
}

#Usage                                         Mostrar uso y versi�n ####

                                        # Si ejecutamos el script sin los par�metros correctos...
if [ $# -eq 0 ]                         # ...mostrar el uso correcto y versi�n del programa.
  then
    usage
    exit 1
fi


#Begin Main                                         Proceso Principal ####

echo -e "\n O-> $PROGRAMA v$Version - Plantilla para programas bash shell.\n"

rm $TEMP > /dev/null 2>&1
if_error  "Fallo al intentar borrar fichero $TEMP."  siOK  "Borrado fichero $TEMP."

echo -e "\n o-> $PROGRAMA Finished.\n"     # msg final

#End Main                                             Fin de Programa ####
