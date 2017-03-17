:: Build a project and run it. Previous binary is deleted before building 
:: and binaries built by the script are deleted after execution.
:: Runs build and execution in silent mode but in case of error repeats in verbose mode.
::   %1 - full path to project file
::   %2 - config (Debug|Release)
::   %3 - platform (Win32|Win64)
::   %4 - (opt) defines
::   %5 - (opt) binary output path, default: .\ (near proj)
:: © Fr0sT

@ECHO OFF

SETLOCAL

IF .%~1.==.. GOTO :NoParam
IF .%~2.==.. GOTO :NoParam
IF .%~3.==.. GOTO :NoParam

SET CDir=%~dp0%
SET BuildCmd=%CDir%\build.bat
SET Proj=%~1
SET BinaryPath=%~5
IF .%BinaryPath%.==.. SET BinaryPath=.\
SET Binary=%~dp1\%BinaryPath%\%~n1.exe
SET ConfigParam=%2
SET PlatformParam=%3
SET DefinesParam=%4

IF .%DefinesParam%.==.. (
	CALL :EchoNoNL %ConfigParam% @ %PlatformParam%...
) ELSE (
	CALL :EchoNoNL %ConfigParam% @ %PlatformParam%, defines %DefinesParam%...
)

:: Remove previous binary
DEL "%Binary%" 2> NUL

:: Build silently, in case of error build verbosily, pause and exit
SET Params="Config=%ConfigParam%;Platform=%PlatformParam%;DCC_ExeOutput=%BinaryPath%"
SET Err=
CALL "%BuildCmd%" "%Proj%" %Params% %DefinesParam% > NUL || SET Err=1
IF DEFINED Err (
	CALL "%BuildCmd%" "%Proj%" %Params% %DefinesParam%
	PAUSE
	GOTO :Err
)

:: Execute silently, in case of error execute verbosily, pause and exit
SET Err=
CALL "%Binary%" > NUL || SET Err=1
IF DEFINED Err (
	CALL "%Binary%"
	PAUSE
	GOTO :Err
)

DEL "%Binary%" 2> NUL
ECHO OK
GOTO :EOF

:: ~~~ SUB ~~~
:: Print a line without line feed
::   %* - line to print
:EchoNoNL
	SET /p "dummy=%*" < NUL
	GOTO :EOF
	
:NoParam
ECHO Param error!

:Err
DEL "%Binary%" 2> NUL
CMD /C EXIT 1