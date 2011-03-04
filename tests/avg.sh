#!/bin/bash

USAGE="\n USAGE: experiment.sh N \n
	N: vegades que s'executara el programa per fer la mitja \n"

N=$1

if [ "$1" = "" ]
then
	N=1
fi

#programa a executar
PROG=../mpeg2/src/mpeg2enc/mpeg2encode

#parametres del programa
PARS='../videos_in/02.tiger.par 02.tiger.m2v'

#fitxer auxiliar
aux=/tmp/aux.$$

elapsed=0
i=0
while (test $i -lt $N)
do
	echo -n Run $i... 
	/usr/bin/time --format=%e -o $aux $PROG $PARS

	time=`cat $aux|tail -n 1`
	echo Elapsed Time = `cat $aux`
	echo
	elapsed=`echo $elapsed + $time|bc`
			
	rm -f $aux
	i=`expr $i + 1`
done

echo -n ELAPSED TIME AVERAGE OF $N EXECUTIONS =

#echo holaaaaaaaaaa? $elapsed
result=`echo $elapsed/$N|bc -l`
echo $result
echo

#./jgraph -P grafica.jgr > grafica.ps
#gs grafica.ps
