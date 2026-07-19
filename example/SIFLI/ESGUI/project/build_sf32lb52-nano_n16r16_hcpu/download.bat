set WORK_PATH=%~dp0
set CURR_PATH=%cd%
cd %WORK_PATH%
jlink.exe -device SF32LB52X_NOR -CommandFile download.jlink
cd %CURR_PATH%
