#!/bin/bash


#GPROF

#make  crea l'executable normal i l'executable amb -pg -g
#make .pg compila nomes el .pg per a gprof
../mpeg2/src/mpeg2enc/mpeg2encode.pg ../videos_in/02.tiger.par ../videos_in/02.tiger.m2v

gprof -l ../mpeg2/src/mpeg2enc/mpeg2encode.pg > out_gprof_l
gprof ../mpeg2/src/mpeg2enc/mpeg2encode.pg > out_gprof
echo sortida escrita a out_gprof, sortida a nivell de linia a out_gprof_l

exit
