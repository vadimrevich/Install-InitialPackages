@echo off
rem *******************************************************
rem checkDef.cmd
rem This Script Checks a Microsoft Windows Version of an OS
rem and if the Windows Defender only Installed in the OS
rem
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Windows 10/11 and Defender Installed
rem		1 if early Windows and Defender Installed
rem		2 if Windows 10/11 and other Antivirus Installed
rem		3 if early Windows and other Antivirus Installed
rem		4 if none Antivirus Installed
rem		5 if none Antivirus Installed
rem		8 if OS is an Windows Vista or Early
rem		16 if a Filesystem Error or Missing a System File
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set System Variables
rem
set pathCMD=%SystemRoot%\system32
set pathWBEM=%pathCMD%\wbem
set FINDEXE=%pathCMD%\find.exe
set POSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe

set GETAVPS1=%~dp0Get-AntivirusDetails.ps1
set CHKOSCMD=%~dp0checkWinOS.cmd

rem Check System Variables
if not exist %pathCMD% echo %pathCMD% not found && exit /b 16
if not exist %pathWBEM% echo %pathWBEM% not found && exit /b 16
if not exist %FINDEXE% echo %FINDEXE% not found && exit /b 16
if not exist %POSHEXE% echo %POSHEXE% not found && exit /b 16
if not exist %CHKOSCMD% echo %CHKOSCMD% not found && exit /b 16
if not exist %GETAVPS1% echo %GETAVPS1% not found && exit /b 16

rem Check OS Version
rem
call %CHKOSCMD%
if %errorlevel% equ 0 goto win_10
if %errorlevel% equ 1 goto win_early
if %errorlevel% equ 2 goto win_vista
if %errorlevel% equ 3 goto unsupported
exit /b 16

:unsupported
echo System is not Supported
exit /b 16

:win_vista
echo System Windows Vista or early. Windows Defender is not Supported
exit /b 8

:win_early

echo Windows Early
rem Check Integrity
rem

%POSHEXE% -ExecutionPolicy Bypass -NoLogo -NoProfile -File %GETAVPS1%
if %errorlevel% equ 0 echo Anttivirus is not instaalled && set /a exitcode=5 && goto win_early_end
if %errorlevel% equ 1 echo Installed Windows Defender && set /a exitcode=1 && goto win_early_end
if %errorlevel% equ 2 echo Installed Kaspersky Products && set /a exitcode=3 && goto win_early_end
if %errorlevel% equ 3 echo Installed Other Antivirus Products && set /a exitcode=3 && goto win_early_end
exit /b 16

rem Check if Antivirus Installed
rem
:win_early_end
if %exitcode% EQU 5 exit /b 5
if %exitcode% EQU 3 exit /b 3
if %exitcode% EQU 1 exit /b 1
exit /b %exitcode%


:win_10

echo Windows 10
rem Check Integrity
rem

rem Check if Antivirus Installed
rem

%POSHEXE% -ExecutionPolicy Bypass -NoLogo -NoProfile -File %GETAVPS1%
if %errorlevel% equ 0 echo Anttivirus is not instaalled && set /a exitcode=4 && goto win_early_end
if %errorlevel% equ 1 echo Installed Windows Defender && set /a exitcode=0 && goto win_early_end
if %errorlevel% equ 2 echo Installed Kaspersky Products && set /a exitcode=2 && goto win_early_end
if %errorlevel% equ 3 echo Installed Other Antivirus Products && set /a exitcode=2 && goto win_early_end
exit /b 16

:win_10_end
exit /b %exitcode%

rem The End of the Script

