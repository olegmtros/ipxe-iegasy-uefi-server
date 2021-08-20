imagex64.exe /apply j:\smb\dist\install_wim\10_2004\install.wim 4 d:
bcdboot d:\windows /s c:
j:\smb\dist\shutdown.exe /r /t 0
