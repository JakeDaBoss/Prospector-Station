set MAPFILE=Mutizphoenix2.dmm

SET z_levels=1
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy %MAPFILE% %MAPFILE%.backup
)

pause