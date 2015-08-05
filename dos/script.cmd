:: script.cmd
:: Author: Andy Bettisworth
:: Description: Manage local scripts

@ECHO OFF

SET dos_scripts=C:%HOMEPATH%\Documents\GitHub\script\dos

IF NOT "%1" == "" (
  IF "%1" == "--setup" (
    IF EXIST %dos_scripts% (
      ECHO Adding dos scripts to PATH variable...
      SETX /M PATH "%PATH%;%dos_scripts%;"
      EXIT /B 0
    ) ELSE (
      ECHO Missing directory %dos_scripts%
      EXIT /B 2
    )
  )
)

ECHO Usage: script [options]
ECHO  --setup   Add dos scripts to PATH variable
EXIT /B 1
