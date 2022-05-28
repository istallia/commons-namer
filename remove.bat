@echo off
chcp 932
rem ニコニコ素材リストアップツール(v0.7)をレジストリから削除するバッチファイル

setlocal

reg delete "HKEY_CURRENT_USER\Software\Classes\*\shell\コモンズ素材を命名" /f
reg delete "HKEY_CURRENT_USER\Software\Classes\Directory\shell\コモンズ素材を命名" /f
