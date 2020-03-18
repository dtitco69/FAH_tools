@echo on

::This is the folder that your install file is located in
SET InstallerLocation=\\gfm-dcs\Deployment\FAH

::This is the data directory you would like to use
SET InstallTo=c:\FAHClient

::This is the name of the Executable to be run
SET FAHEXE=fah-installer_7.5.1_x86.exe

ECHO This Script will install Folding at Home - This install is interactive and must be completed by an admin
REM

::Test If script has Admin Priviledges/is elevated
net session >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
ECHO you are Administrator - with great power comes great responsibility
) ELSE (
ECHO you are NOT Administrator. Exiting...
PING 127.0.0.1 > NUL 2>&1
EXIT /B 1
)

::tell user the settings to use
ECHO ensure a custom install with the following data path %InstallTo%
ECHO DO NOT START F@H after install
PAUSE

::start the install process
%InstallerLocation%\%FAHEXE%

REM
PAUSE

::copy the config file to the modified data directory
COPY /y %InstallerLocation%\config_laptop.xml %InstallTo%\config.xml
ECHO copying config laptop.xml

::copy the shortcut to the allusers startup folder
COPY /b/v/y "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\Folding@home.lnk" "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Folding@home.lnk"
ECHO creating startup shortcut

::Tidy up build environment
DEL "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\Folding@home.lnk"

REM
ECHO all done! please reboot to start folding
PAUSE
