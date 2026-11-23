@echo off
rem *******************************************************
rem checkDef.cmd
rem This Script Checks a Microsoft Windows Version of an OS
rem and if the Windows Defender only Installed in the OS
rem
rem Attention!!! File at CP866 Code page
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Windows 10/11 or Server 2016+
rem		1 if early Windows 7-8.1 or Server 2008R2-2012R2
rem		2 if OS is an Windows Vista or Early or Server 2008 and Early
rem		3 if OS is unsupported
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
set BITSADMINEXE=%pathCMD%\bitsadmin.exe
set FINDEXE=%pathCMD%\find.exe
set CHKLANG=%~dp0checkCodePage.cmd

rem Check System Variables
if not exist %pathCMD% echo %pathCMD% not found && exit /b 16
if not exist %pathWBEM% echo %pathWBEM% not found && exit /b 16
if not exist %FINDEXE% echo %FINDEXE% not found && exit /b 16
if not exist %CHKLANG% echo %CHKLANG% not found && exit /b 16

call %CHKLANG% > NUL 2>&1
if %errorlevel% equ 20 echo Unsupported Language of the OS && exit /b 3

rem Check OS Version
rem
ver | %SystemRoot%\system32\find.exe "Windows [Version 10" > nul
if not errorlevel 1 goto win_10
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.3" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.2" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.1" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows XP" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Version 5.2" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Версия 5.2" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Version 5.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Версия 5.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "win" > nul
if not errorlevel 1 goto win_vista
echo System UnSupported
goto Unsupported

:Unsupported
echo System UnSupported. Check your OS.
exit /b 3

:win_vista
echo System Windows Vista or early. Windows Defender is not Supported
exit /b 2

:win_early

echo Windows Early (6.1-6.3) is Installed. Some Features are not Supported
rem Check Integrity
rem

exit /b 1


:win_10

echo Windows 10/11 is Installed. All Features are Supported
rem Check Integrity
rem
exit /b 0

rem The End of the Script
