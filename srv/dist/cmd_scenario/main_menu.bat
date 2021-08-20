@echo off
echo "TEST"
set xOS=86
setlocal enabledelayedexpansion 
if "%processor_architecture%"=="AMD64" set xOS=64
::#display_main

:main_menu
echo "________________________________________________"
echo ""
echo "                   MAIN MENU                    "
echo "________________________________________________"
echo ""
echo "       select options. type char, press enter   "
echo ""
echo "1) Normal install windows 10"
echo "2) for backup.mount share & start disk2vhd (submenu)"
echo "3) ^!NEED ERASE FIRST^! install with imagex. 10/8/7. any x64 version (submenu)"
echo "4) Normal install. windows 8/7 (no way - not woking. who else need that?)"
echo "cmd) open another cmd window"
echo "w10) just install 10pro&reboot (without any question)"
echo "AR) ERASE & INSTALL W10 ANSIBLE READY & reboot (without any question)"
echo "________________________________________________"
echo ""
echo "er) erase disk (submenu)"
::#end_display_menu

::#main_menu_code
set /p mm_choise="give the number or char: "
if "%mm_choise%"=="1" (goto m1)
if "%mm_choise%"=="2" (goto backup)
if "%mm_choise%"=="3" (goto imagex_main)
if "%mm_choise%"=="4" (goto main_menu)
if "%mm_choise%"=="er" (goto diskpart_menu)
if "%mm_choise%"=="cmd" (start cmd && goto main_menu)
if "%mm_choise%"=="w10" (goto w10_AR)
if "%mm_choise%"=="AR" (goto w10_AR)

echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto main_menu
:m1

echo "mount & install w10"
set TPI=Z:\iso\win10.iso
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
imdisk -a -f "%TPI%" -m K:
K:\setup.exe
goto main_menu

:imw10
echo "choose you figter"
echo "1) uefi disk erase"
echo "2) legasy disk erase"
set /p fighter_choise="you number: "
if "%fighter_choise%"=="1" (set fighter_choise=64 && goto imw10_true)
if "%fighter_choise%"=="2" (set fighter_choise=86 && goto imw10_true)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto main_menu

:imw10_true
start /wait %~dp0erasedisk%fighter_choise%.bat
echo "mount & install w10"
set TPI=Z:\iso\win10.iso
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
imdisk -a -f "%TPI%" -m K:
%~dp0tools\imagex%xOS%.exe /apply K:\sources\install.wim 4 d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu

:w10_AR
echo "choose you figter"
echo "1) uefi disk erase"
echo "2) legasy disk erase"
set /p fighter_choise="you number: "
if "%fighter_choise%"=="1" (set fighter_choise=64 && goto w10_AR_true)
if "%fighter_choise%"=="2" (set fighter_choise=86 && goto w10_AR_true)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto main_menu

:w10_AR_true
start /wait %~dp0erasedisk%fighter_choise%.bat
echo "install w10 ANSIBLE_READY"
%~dp0tools\imagex%xOS%.exe /apply Z:\iso\win10pAR.wim 1 H: && bcdboot H:\windows /s G: && wpeutil reboot || echo "something went wrong" && goto main_menu

::#end_main_menu_code

########################################################################################################

#display_backup
:backup

echo "________________________________________________"
echo ""
echo               "mount share & backup"             
echo "________________________________________________"
echo ""
echo       "select options. type char, press enter"
echo 
echo "1) connect standart share (automatic mount A: & B:)"
echo "2) connect yourself share (manual input)"
echo "3) start disk2vhd"
echo "r) return to main menu"
echo ""
echo "________________________________________________"
echo ""
::#end_display_backup

::#backup_code
set /p bk_choise="give the number or char: "
if "%bk_choise%"=="1" (goto auto_mount)
if "%bk_choise%"=="2" (goto bk_manual)
if "%bk_choise%"=="3" ("%~dp0tools\disk2vhd%xOS%.exe" && goto backup)
if "%bk_choise%"=="r" (goto main_menu)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto backup

:auto_mount
net use a: \\srvinstall\VHD1 /user:srvinstall\install ZZcc22
net use b: \\srvinstall\VHD2 /user:srvinstall\install ZZcc22
goto backup
:bk_manual
set /p bk_host="give ip or name of bk host: "
echo %bk_host%
set /p bk_path="give path: "
echo %bk_path%
set /p bk_uname="give privileged user name like that (domain_or_ip_hostname^\user_name): "
set /p bk_password="give password: "
net use a: \\%bk_host%\%bk_path% /user:%bk_uname% %bk_password% || (echo "something went wrong. try again" & goto backup)
goto backup
#end_backup_code
########################################################################################################


#display_imagex
:imagex_main

echo "________________________________________________"
echo ""
echo               "install with imagex"               
echo "________________________________________________"
echo ""
echo "IF INSTALL PATH IS DIFFERENT AS"
echo "D:\ - FOR WINDOWS"
echo "AND"
echo "C:\ FOR BOOTFILES"
echo "RUN DISKPART & CHANGE IT"
echo ""
echo      "select options. type char, press enter"
echo ""
echo "1) open diskpart"
echo "2) install w10_pro"
echo "3) install w7 pro with DRV AGRO_MACHINES"
echo "4) install w7 pro"
echo "5) select another version w10 (submenu)"
echo "6) select another version w7 (submenu)"
echo "7) select another version w8.1"
echo "r) return to main menu"
echo "________________________________________________"
echo ""
echo "er) erase disk (submenu)"
echo ""
::#end_display_imagex

::#imagex_code
set /p im_choise="give the number or char: "
if "%im_choise%"=="1" (start cmd /K diskpart && goto imagex_main)
if "%im_choise%"=="2" (goto im_uni_install && set TPI=Z:\iso\win10.iso && set index_wim=4)
if "%im_choise%"=="3" (goto im_uni_install)
if "%im_choise%"=="4" (goto im_uni_install && set TPI=Z:\iso\win7.iso && set index_wim=3)
if "%im_choise%"=="5" (goto imagex_w10)
if "%im_choise%"=="6" (goto imagex_w7)
if "%im_choise%"=="7" (goto imagex_w8)
if "%im_choise%"=="r" (goto main_menu)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto imagex_main

:im_uni_install
echo "mount & install %TPI%"
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
imdisk -a -f "%TPI%" -m K:
%~dp0tools\imagex%xOS%.exe /apply K:\sources\install.wim %index_wim% d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu
goto main_menu

:im_install_7_pro_drv
%~dp0tools\imagex%xOS%.exe /apply Z:\iso\win7drv.wim 3 d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu
goto main_menu

#end_imagex_code

########################################################################################################

#display_w7
:imagex_w7

echo "________________________________________________"
echo ""
echo       "select another version w7 (submenu)"      
echo "________________________________________________"
echo ""
echo "IF INSTALL PATH IS DIFFERENT AS D:\ - FOR WINDOWS"
echo "AND C:\ FOR BOOTFILES - RUN DISKPART & CHANGE IT"
echo ""
echo      "select options. type char, press enter"
echo ""
echo ""
echo "1) w7 HomeBasic		index=1"
echo "2) w7 HomePremium 	index=2"
echo "3) w7 Professional 	index=3"
echo "4) w7 Ultimate 		index=4"
echo ""
echo "r) return to main menu"
echo ""
echo "________________________________________________"
echo ""
::#end_display_w7
::#w7_code
set index=0
set /p index="choose index: "
if "%index%"=="1" (set TPI=Z:\iso\win7.iso && set index_wim=1 && goto im_uni_install)
if "%index%"=="2" (set TPI=Z:\iso\win7.iso && set index_wim=2 && goto im_uni_install)
if "%index%"=="3" (set TPI=Z:\iso\win7.iso && set index_wim=3 && goto im_uni_install)
if "%index%"=="4" (set TPI=Z:\iso\win7.iso && set index_wim=4 && goto im_uni_install)
if "%index%"=="r" (goto main_menu)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto imagex_w7

#end_w7_code
########################################################################################################

#display_wx
:imagex_w10

echo "________________________________________________"
echo ""
echo       select another version w10 (submenu)      
echo "________________________________________________"
echo ""
echo IF INSTALL PATH IS DIFFERENT AS D:\ - FOR WINDOWS
echo AND C:\ FOR BOOTFILES - RUN DISKPART & CHANGE IT
echo ""
echo      select options. type char, press enter
echo ""
echo ""
echo "1) w10 Home 				index=1"
echo "2) w10 Home Single Language 		index=2"
echo "3) w10 Education 				index=3"
echo "4) w10 Professional 			index=4"
echo ""
echo "r) return to main menu"
echo ""
echo "________________________________________________"
echo ""
::#end_display_wx

::#wx_code
set index=0
set /p index="choose index: "
if "%index%"=="1" (set index=1 && goto mount_w10)
if "%index%"=="2" (set index=2 && goto mount_w10)
if "%index%"=="3" (set index=3 && goto mount_w10)
if "%index%"=="4" (set index=4 && goto mount_w10)
if "%index%"=="r" (goto main_menu)

echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto imagex_w10

:mount_w10
echo "mount & install w10"
set TPI=iso\win10.iso
if not "%TPI%"=="" (FOR %%i IN (A B C D E F G H I J K L N M O P Q R S T U V W Y Z) DO IF EXIST "%%i:\%TPI%" SET RPI=%%i:\%TPI%)
if "%RPI%"=="" (if exist "%systemroot%\syswow64" "%~dp0mount\select iso file 64.exe" else "%~dp0mount\select iso file 32.exe")
0<"%~dp0SelectFileISO.txt" set /p "RPI="
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
::del "%~dp0\mount\SelectFileISO.txt" /f
imdisk -a -f "%RPI%" -m #:
set find_install=setup.exe
set ifind=""
if not "%find_install%"=="" (FOR %%i IN (A B C D E F G H I J K L N M O P Q R S T U V W Y Z) DO IF EXIST "%%i:\%find_install%" set ifind=%%i)
%~dp0tools\imagex%xOS%.exe /apply %ifind%:\sources\install.wim %index% d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu
::bcdboot d:\windows /s c:
::wpeutil reboot
::%~dp0shutdown%xOS%.exe /r /t 0 
goto main_menu
#end_wx_code
########################################################################################################

:imagex_w8
echo "________________________________________________"
echo ""
echo       select another version w8 (submenu)      
echo "________________________________________________"
echo ""
echo IF INSTALL PATH IS DIFFERENT AS D:\ - FOR WINDOWS
echo AND C:\ FOR BOOTFILES - RUN DISKPART & CHANGE IT
echo ""
echo      select options. type char, press enter
echo ""
echo ""
echo "1) w8 single language"
::echo "2) w10 Home Single Language 	index=2"
::echo "3) w10 Education 				index=3"
::echo "4) w10 Professional 			index=4"
echo ""
echo "r) return to main menu"
echo ""
echo "________________________________________________"
echo ""
::#end_display_wx

::#wx_code
set path=0
set /p path="choose index: "
if "%path%"=="1" (set path=SLRx64 && goto mount_w8)
::if "%index%"=="2" (set index=2 && goto mount_w8)
::if "%index%"=="3" (set index=3 && goto mount_w8)
::if "%index%"=="4" (set index=4 && goto mount_w8)
if "%path%"=="r" (goto main_menu)

echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
goto imagex_w8

:mount_w8
echo "mount & install w8"
set TPI=iso\win8.1_%path%.iso
if not "%TPI%"=="" (FOR %%p IN (A B C D E F G H I J K L N M O P Q R S T U V W Y Z) DO IF EXIST "%%p:\%TPI%" SET RPI=%%p:\%TPI%)
if "%RPI%"=="" (if exist "%systemroot%\syswow64" "%~dp0mount\select iso file 64.exe" else "%~dp0mount\select iso file 32.exe")
0<"%~dp0SelectFileISO.txt" set /p "RPI="
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
::del "%~dp0\mount\SelectFileISO.txt" /f
imdisk -a -f "%RPI%" -m #:
set find_install=setup.exe
set ifind=""
if not "%find_install%"=="" (FOR %%o IN (A B C D E F G H I J K L N M O P Q R S T U V W Y Z) DO IF EXIST "%%o:\%find_install%" set ifind=%%o)
%~dp0tools\imagex%xOS%.exe /apply %ifind%:\sources\install.wim 1 d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu
goto main_menu
#end_w7_code

:uni_imax_code_quick
:imw10_true
start /wait %~dp0erasedisk%fighter_choise%.bat
echo "mount & install w10"
set TPI=Z:\iso\%isofile%
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %~dp0mount\imdisk\imdisk.inf
imdisk -a -f "%RPI%" -m K:
%~dp0tools\imagex%xOS%.exe /apply K:\sources\install.wim 4 d: && bcdboot d:\windows /s c: && wpeutil reboot || echo "something went wrong" && goto main_menu


########################################################################################################

#display_erase
:diskpart_menu

echo "________________________________________________"
echo ""
echo              ERASE DISK BY DISKPART             
echo "________________________________________________"
echo ""
echo      select options. type char, press enter
echo ""
echo "1) ERASE disk 0 (automatically_uefi)"
echo "2) ERASE disk 0 (automatically_legasy)"
echo "3) open diskpart (manual input)"
echo "r) return to main menu"
echo ""
echo "________________________________________________"
echo ""
::#end_display_erase

::#erase_code
set /p dp_index="choose number: "
if "%dp_index%"=="1" (start %~dp0erasedisk64.bat && goto main_menu)
if "%dp_index%"=="2" (start %~dp0erasedisk86.bat && goto main_menu)
if "%dp_index%"=="3" (start diskpart && goto diskpart_menu)
if "%dp_index%"=="r" (goto main_menu)
echo you choise is wrong - try again
set /p wrong="you regret about that. press rightnow enter button"
::#end_erase_code
