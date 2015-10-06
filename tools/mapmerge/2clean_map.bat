set MAPFILE=Mutizphoenix2.dmm

SET z_levels=1
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/%MAPFILE%.backup ../../maps/%MAPFILE% ../../maps/%MAPFILE%
)

pause
