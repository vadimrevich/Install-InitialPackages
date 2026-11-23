@echo OFF
rem *******************************************************
rem checkArch.bat
rem This Script will Check if OS running at x64 or x32
rem Mode
rem 
rem RETURNS:	0 ir OS is amd64
rem		1 if OS is x68
rem		20 if check integrity error
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set System Variables
rem
set pathCMD=%SystemRoot%\system32
set pathWBEM=%pathCMD%\wbem
set REGEXE=%pathCMD%\reg.exe

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 20

rem Run Payloads...

set ProcArch=NoneIntelArmFamily

%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set ProcArch=Intel32BIT 

%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "Intel64" > NUL && set ProcArch=Amd64BIT
%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "Amd64" > NUL && set ProcArch=Amd64BIT
%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "Arm64" > NUL && set ProcArch=Arm64BIT
%REGEXE% Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "aarch" > NUL && set ProcArch=Arm64BIT

if %ProcArch%==Intel32BIT echo This is an 32bit operating system on old processor && exit /b 1
if %ProcArch%==NoneIntelArmFamily echo Check Integrity Error Processor neither Intel nor ARM Family && exit /b 20
if %ProcArch%==Amd64BIT echo This is Amd64 Architecture
if %ProcArch%==Arm64BIT echo This is Amd64 emulated on Arm64 Processor Architecture


:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
IF %PROCESSOR_ARCHITECTURE% == AMD64 echo This AMD64 Architecture && GOTO OS64PRINT 
IF %PROCESSOR_ARCHITECTURE% == IA64 echo This IA64  (Intel Itanium) Architecture && GOTO OS64PRINT
IF %PROCESSOR_ARCHITECTURE% == ARM64 echo This ARM64 (aarch64) Architecture && GOTO OS64PRINT
IF %PROCESSOR_ARCHITECTURE% == x86 GOTO 32BIT
GOTO NONEINTELOS

:OS64PRINT
echo This is a 64bit operating system
exit /b 0
GOTO END

:32BIT
IF DEFINED PROCESSOR_ARCHITEW6432 GOTO OS64PRINT
echo This is an Intel 32bit operating system && exit /b 1

:NONEINTELOS
echo There is neither Intel nor Intel emulated
exit /b 20
GOTO END

:END
