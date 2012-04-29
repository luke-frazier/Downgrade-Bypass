@echo off
color 0a
title                                           Thunderbolt Downgrade Bypass
IF NOT EXIST support_files (GOTO UNZIP-ERR)
support_files\adb kill-server
support_files\adb start-server
:uname
IF "%USERNAME%" == "Owner" (GOTO MENU)
IF "%USERNAME%" == "Home" (GOTO MENU)
IF "%USERNAME%" == "User" (GOTO MENU)
IF "%USERNAME%" == "Admin" (GOTO MENU)
IF "%USERNAME%" == "Administrator" (GOTO MENU)
:HELLO
cls
echo Welcome %USERNAME%!
:MENU
echo.
echo                         ******************************
echo                         *    Downgrade bypass tool   *
echo                         *       Made by trter10      *
echo                         * Thanks TeamWin for fre3vo! *
echo                         ******************************
echo.
echo Please have your phone in charge only mode.
echo.
echo Please enable "Stay Awake" and "USB Debugging" in Settings - Apps - Development.
echo Also, please disable any programs like EasyTether, PDANet, HTC Sync, etc.
echo.
set /p M=Do you have the fastboot drivers installed? [Y/N] 
IF %M%==Y (GOTO START)
IF %M%==y (GOTO START)
IF %M%==N (GOTO DRIVER)
IF %M%==n (GOTO DRIVER)
GOTO HELLO
:DRIVER
START support_files\Driver.exe
echo.
echo Press enter once the driver is installed.
echo.
pause >NUL
:START
echo.
echo -Waiting for device...
support_files\adb wait-for-device
echo -Found!
echo.
support_files\adb shell getprop ro.aa.romver >support_files\rver
set /p romver=<support_files\rver
echo -Getting root with fre3vo, thanks TeamWin!
echo -This will take a minute.
support_files\adb push support_files\fre3vo /data/local/fre3vo >NUL
support_files\adb shell chmod 777 /data/local/fre3vo
support_files\adb shell /data/local/fre3vo -debug -start F0000000 -end FFFFFFFF >NUL
support_files\adb wait-for-device
support_files\adb shell rm /data/local/fre3vo
cls
echo.
echo.
support_files\adb root >support_files\adb-running-as
set /p rooted=<support_files\adb-running-as
::Ensuring root was successful...
IF "%rooted%"=="adbd is already running as root" (GOTO SUCCESSFUL) ELSE (GOTO UNSUCCESSFUL)
:SUCCESSFUL
cls
color 0c
echo -Success!
echo.
support_files\adb shell getprop ro.bootloader >support_files\bl
support_files\adb shell getprop ro.serialno >support_files\sn
echo -Restarting adb...
support_files\adb kill-server >NUL
support_files\adb start-server >NUL
echo.
set /p serialno=<support_files\sn
set /p hbootver=<support_files\bl
del support_files\adb-running-as
del support_files\sn
del support_files\bl
del support_files\rver
echo X = MsgBox("On the revolutionary website, please scroll down to Download for Windows. Click that button, then cancel the download. Enter your phone's information in the prompts that pop up. The info you need is: Seiral Number: %serialno% Hboot version: %hbootver%. Once you do that, copy your beta key from the website, then paste it into the Revolutionary window. To paste it, right click the title bar of the Revolutionary window then click edit then click paste. If there are two revolutionary windows, you can close one. Please note that for Revolutionary to work you need to uninstall Droid Explorer if you have it. Thanks!",0+64+4096, "PLEASE READ - Message from trter10")>support_files\rev.vbs
echo X = MsgBox("Please note that you need to enter Y to download and flash CWM recovery at the end of Revolutionary. After Revolutionary completes, using the volume buttons to navigate and power to select, you will need to exit fastboot by selecting bootloader, waiting a few seconds, then selecting recovery. Then, CWM will automatically install superuser and reboot.",0+64+4096, "PLEASE READ - Message from trter10")>>support_files\rev.vbs
echo -Putting superuser files on your sdcard...
support_files\adb wait-for-device
support_files\adb push support_files\su.zip /sdcard/su.zip
support_files\adb push support_files\extendedcommand /cache/recovery/extendedcommand
echo.
echo -Starting Revolutionary and the Website....
START iexplore.exe Revolutionary.io
START support_files\Revolutionary.exe
START support_files\Revolutionary.exe
START support_files\rev.vbs
exit
:UNSUCCESSFUL
cls
echo.
del support_files\rver
del support_files\adb-running-as
echo -Root unsuccessful! :(
echo.
echo -Try pulling your battery and running again.
echo.
pause
exit
:UNZIP-ERR
cls
color 0c
echo.
echo It appears that you did not unzip the file correctly. Please manually unzip it  without using a program like 7-zip.
echo.
pause
exit