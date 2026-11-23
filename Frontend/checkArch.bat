@echo OFF
rem *******************************************************
rem checkArch.bat
rem This Script will Check if OS running at x64 or x32
rem Mode
rem 
rem RETURNS:	0 ir OS is amd64
rem		1 if OS is x68
rem		20 if check integrity error
rem		21 if WMIC.EXE is not Installed
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set System Variables
rem
set pathCMD=%SystemRoot%\system32
set pathWBEM=%pathCMD%\wbem
set REGEXE=%pathCMD%\reg.exe
set WMICEXE=%pathWBEM%\WMIC.EXE

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 20
if not exist %WMICEXE% echo %WMICEXE% is not Found. Install this Component. && exit /b 21

rem Run Payloads...

%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set ProcArch=32BIT || set ProcArch=64BIT

if %ProcArch%==32BIT echo This is a 32bit operating system && exit /b 1
if not %ProcArch%==64BIT echo Check Integrity Error && exit /b 20 

:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
echo This is a 64bit operating system
exit /b 0
GOTO END

:32BIT
echo This is a 32bit operating system && exit /b 1
exit /b 1
GOTO END

:END
