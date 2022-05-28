@echo off
chcp 932
rem ニコニコ素材リストアップツール(v0.7)をレジストリに登録するバッチファイル

setlocal
set APP_PATH=%~dp0commons_namer.exe
set COMMAND1=\"%APP_PATH%\"
set COMMAND2=\"%%1\"
set COMMAND3=%COMMAND1% %COMMAND2%
echo %COMMAND1% %COMMAND2%

reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\コモンズ素材を命名" /v "Icon" /t REG_SZ /d "%APP_PATH%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\コモンズ素材を命名\command" /ve /t REG_SZ /d "%COMMAND3%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\コモンズ素材を命名" /v "Icon" /t REG_SZ /d "%APP_PATH%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\コモンズ素材を命名\command" /ve /t REG_SZ /d "%COMMAND3%" /f
