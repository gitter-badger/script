:: dos-scripts.cmd
:: Author: Andy Bettisworth
:: Description: Add GitHub scripts to local PATH

@ECHO OFF

SET admin_scripts=C:%HOMEPATH%\GitHub\script\admin
SET dos_scripts=C:%HOMEPATH%\GitHub\script\dos

IF NOT "%1" == "" (
  IF "%1" == "--setup" (
    IF EXIST %dos_scripts% (
      ECHO Adding dos scripts to PATH variable...
      SETX /M PATH "%PATH%;%dos_scripts%;"
      SETX /M PATH "%PATH%;%admin_scripts%;"
      EXIT /B 0
    ) ELSE (
      ECHO Missing directory %dos_scripts%
      EXIT /B 2
    )
  )
)

ECHO Usage: dos-scripts [options]
ECHO  --setup   Add dos scripts to PATH variable
EXIT /B 1
