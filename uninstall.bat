@echo off
set mypath=%~dp0
set command=%mypath%uninstall.ps1
set command=%command: =` %
powershell %command%
