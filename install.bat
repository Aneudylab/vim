@echo off
set mypath=%~dp0
set command=%mypath%install.ps1
set command=%command: =` %
powershell %command%
