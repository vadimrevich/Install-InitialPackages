@echo off
rem *******************************************************
rem checkCodePage.cmd
rem This Script will Check a Windows CodePage and Return
rem a Result
rem
rem RETURNS:	0 if a Russian Codepage is Present
rem		1 if an English Codepage is Present
rem		20 if a Check Integrity Error Occur or an other Codepage
rem		21 if a WMIC.EXE is nit Found
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
set FINDEXE=%pathCMD%\find.exe

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 20
rem if not exist %WMICEXE% echo %WMICEXE% is not Found. Install this Component. && exit /b 21
if not exist %FINDEXE% echo %FINDEXE% is not Found && exit /b 20

rem Run Payloads...
rem %WMICEXE% path Win32_OperatingSystem get oslanguage|more +1|set/p x=^& cmd/v/c if "!x: =!"=="1049" (
rem echo:CodePage is RU && exit /b 0
rem ) else (if "!x: =!"=="1033" (
rem echo:Codepage is EN && exit /b 1))

%REGEXE% query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage | %FINDEXE% "0419" > NUL 2>&1
if %errorlevel% EQU 0 echo:CodePage is RU && exit /b 0
%REGEXE% query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage | %FINDEXE% "0409" > NUL 2>&1
if %errorlevel% EQU 0 echo:Codepage is EN && exit /b 1

echo An other Code page or a System Error
exit /b 20

pause
