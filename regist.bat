@echo off
chcp 932
rem �j�R�j�R�f�ރ��X�g�A�b�v�c�[��(v0.7)�����W�X�g���ɓo�^����o�b�`�t�@�C��

setlocal
set APP_PATH=%~dp0commons_namer.exe
set COMMAND1=\"%APP_PATH%\"
set COMMAND2=\"%%1\"
set COMMAND3=%COMMAND1% %COMMAND2%
echo %COMMAND1% %COMMAND2%

reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\�R�����Y�f�ނ𖽖�" /v "Icon" /t REG_SZ /d "%APP_PATH%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\�R�����Y�f�ނ𖽖�\command" /ve /t REG_SZ /d "%COMMAND3%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\�R�����Y�f�ނ𖽖�" /v "Icon" /t REG_SZ /d "%APP_PATH%" /f
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\�R�����Y�f�ނ𖽖�\command" /ve /t REG_SZ /d "%COMMAND3%" /f