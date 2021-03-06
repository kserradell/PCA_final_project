#!/bin/bash


trap 'echo -e "\n Control-C premut, script detingut"; tput sgr0; exit 1' 2


USAGE="\n USAGE: compara.sh N \n
	N: vegades que s'executaran tots dos programes per fer la mitja, default 1 \n"

N=$1

if [ "$1" = "" ]
then
	N=1
fi


if (test $# -gt 1)
then
	echo -e $USAGE
	exit 0					
fi	




#programa a executar amb optimitzacio
PROG=../mpeg2/src/mpeg2enc/mpeg2encode

#programa amb el que comparar (de moment l'executable original compilat amb gcc -O3)
PROG_ANT=../original/mpeg2encode

#parametres del programa
PARS='../videos_in/02.tiger.par tiger.optimitzat.m2v'
PARS_ANT='../videos_in/02.tiger.par tiger.anterior.m2v'

#PARS='../videos_in/02.tiger.par ../original/02.tiger.m2v'
#fitxer auxiliar
aux=/tmp/aux.$$

elapsed=0
i=0


echo Executant el programa optimitzat $N vegades:

while (test $i -lt $N)
do
	echo -n "   Run $i..."
	/usr/bin/time --format=%e -o $aux $PROG $PARS 2> /dev/null

	time=`cat $aux|tail -n 1`
	echo Elapsed Time = `cat $aux`
	echo
	elapsed=`echo $elapsed + $time|bc`
			
	rm -f $aux
	i=`expr $i + 1`
done

result_optimitzat=`echo $elapsed/$N|bc -l`


if (cmp tiger.optimitzat.m2v ../original/tiger_original.m2v)
    then

        echo -e '\E[49;32m'"Sortida correcta"   # Green
       #echo Sortida correcta

    else
       echo -e '\E[49;31m'"La sortida de la versio optimitzada no es correcta"
      # echo La sortida de la versio optimitzada no es correcta
fi
 tput sgr0 #restaura el color a la consola
echo
echo Executant el programa anterior $N vegades:

elapsed=0
i=0
while (test $i -lt $N)
do
	echo -n "   Run $i..." 
	/usr/bin/time --format=%e -o $aux $PROG_ANT $PARS_ANT 2> /dev/null

	time=`cat $aux|tail -n 1`
	echo Elapsed Time = `cat $aux`
	echo
	elapsed=`echo $elapsed + $time|bc`
			
	rm -f $aux
	i=`expr $i + 1`
done

result_anterior=`echo $elapsed/$N|bc -l`

echo RESULTS:
echo -n ELAPSED TIME AVERAGE OF $N EXECUTIONS: PREVIOUS VERSION =
echo $result_anterior
echo

echo -n ELAPSED TIME AVERAGE OF $N EXECUTIONS: OPTIMIZED VERSION =
echo $result_optimitzat






speedup=`echo $result_anterior/$result_optimitzat|bc -l`
echo SPEEDUP = $speedup


#./jgraph -P grafica.jgr > grafica.ps
#gs grafica.ps
