:: Build a project.
::   %1 - path to .*proj file
::   %2 - (opt) project properties (Project\PropertyGroup items, separated by ";").
::     * Config=Release|Debug|...
::     * Platform=Win32|Win64|...
::     If omitted, properties from proj file will be used.
::   %3 - (opt) defines separated by ";"
:: © Fr0sT

@ECHO OFF

SETLOCAL

IF .%~1.==.. GOTO :NoParam

IF NOT .%2.==.. SET Props=/property:%~2
:: If defines are given via /property, they overwrite the project's set.
:: Setting defines via env var adds them to the project's set.
IF NOT .%3.==.. SET DCC_Defines=%~3
SET ProjDir=%~dp1

:: Set environment (file must be in PATH)
CALL rsvars.bat

:: MSBuild requires project dir to be current
PUSHD "%ProjDir%"
CALL msbuild.exe /t:build /nologo /verbosity:m "%Props%" "%~1" || (POPD && GOTO :Err)
POPD

GOTO :EOF

:NoParam
ECHO Param error!

:Err
CMD /C EXIT 1