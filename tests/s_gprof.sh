#!/bin/bash


#GPROF
../mpeg2/src/mpeg2enc/mpeg2encode.pg ../videos_in/02.tiger.par ../videos_in/02.tiger.m2v

gprof -l ../mpeg2/src/mpeg2enc/mpeg2encode.pg

exit
