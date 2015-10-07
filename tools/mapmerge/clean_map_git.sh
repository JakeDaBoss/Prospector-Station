#!/bin/sh

set MAPFILE=Mutizphoenix2.dmm

SET z_levels=1
cd 

git show HEAD:maps/$MAPFILE > tmp.dmm
FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/%MAPFILE%.backup ../../maps/%MAPFILE% ../../maps/%MAPFILE%
)

pause