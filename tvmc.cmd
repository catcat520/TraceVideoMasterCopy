@ECHO OFF
CLS
:StartTrace
set runpath=%~dp0
path %path%;%runpath%mimiLIB
MD "%runpath%TempDown">nul 2>nul
MD "%runpath%iqiyi">nul 2>nul
CALL :FUN_iqiyi
CALL :FUN_letv
CALL :FUN_youku
title VER:2015.08.27.06 TraceVideoMasterCopy , 跟踪和记录原始的影音网页内容
SET/p echoloop=离下次检测还有 : <NUL
REM 2h=7200s 4h=14400s 8h=28800s
mimitimeout.runexe /t 14400 /nobreak
GOTO :StartTrace

:FUN_youku
REM 优酷
DEL /q "%runpath%TempDown\youku.in.html">nul 2>nul
DEL /q "%runpath%TempDown\youku.out.html">nul 2>nul
DEL /q "%runpath%TempDown\youku.in.live.html">nul 2>nul
ECHO 优酷

REM 站内播放
mimiwget.runexe --timeout=30 -c "http://www.iqiyi.com/dianshiju/20110608/5549a1c66a33f8e3.html" -O "%runpath%TempDown\iqiyi.in.html">nul 2>nul
FOR /f "delims== tokens=2*" %%i in ('type "%runpath%TempDown\iqiyi.in.html"^|findstr "data-flashplayerparam-flashurl=.*\.swf" 2^>nul^|mimised.runexe "s/\""//g"') DO SET iqiyi.in.swf=%%i
ECHO in : %iqiyi.in.swf%
FOR /f %%i in ('echo %iqiyi.in.swf%^|mimised.runexe "s/http:.*flashplayer\///;s/\/.*//"') DO set iqiyi.in.swf.Date=%%i
MD "%runpath%iqiyi\in\%iqiyi.in.swf.date%">nul 2>nul
ECHO %iqiyi.in.swf%>"%runpath%iqiyi\in\%iqiyi.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %iqiyi.in.swf.date%
FOR /f %%i in ('echo %iqiyi.in.swf%^|mimised.runexe "s/http:.*flashplayer.*\///"') DO set iqiyi.in.swf.File=%%i
REM ECHO in.File : %iqiyi.in.swf.File%
mimiwget.runexe --timeout=30 -c %iqiyi.in.swf% -O "%runpath%iqiyi\in\%iqiyi.in.swf.date%\iqiyi.in.%iqiyi.in.swf.File%">nul 2>nul

REM 站外播放
mimiwget.runexe --timeout=30 --spider http://v.youku.com/v_show/id_XMTI1ODc5MjU2NA==.html 2>"%runpath%TempDown\letv.out.html"
FOR /f %%i in ('type "%runpath%TempDown\letv.out.html"^|findstr "playerUrl" 2^>nul^|mimised.runexe "s/.*http/http/g;s/\.swf.*;/.swf/g"') DO SET letv.out.swf=%%i
ECHO out : %letv.out.swf%
FOR /f %%i in ('echo %iqiyi.out.swf%^|mimised.runexe "s/http:.*flashplayer\///;s/\/.*//"') DO set iqiyi.out.swf.Date=%%i
MD "%runpath%iqiyi\out\%iqiyi.out.swf.date%">nul 2>nul
ECHO %iqiyi.out.swf%>"%runpath%iqiyi\out\%iqiyi.out.swf.date%\out.downlink.txt"
REM ECHO out.date : %iqiyi.out.swf.date%
FOR /f %%i in ('echo %iqiyi.out.swf%^|mimised.runexe "s/http:.*flashplayer.*\///"') DO set iqiyi.out.swf.File=%%i
REM ECHO out.File : %iqiyi.out.swf.File%
mimiwget.runexe --timeout=30 -c %iqiyi.out.swf% -O "%runpath%iqiyi\out\%iqiyi.out.swf.date%\iqiyi.out.%iqiyi.out.swf.File%">nul 2>nul

GOTO :TrueEND

:FUN_letv
REM 乐视
DEL /q "%runpath%TempDown\letv.in.html">nul 2>nul
DEL /q "%runpath%TempDown\letv.out.html">nul 2>nul
DEL /q "%runpath%TempDown\letv.in.live.html">nul 2>nul
ECHO 乐视

REM 站内播放
mimiwget.runexe --timeout=30 -c "http://www.letv.com/ptv/vplay/22840741.html" -O "%runpath%TempDown\letv.in.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\letv.in.html"^|findstr "version:[" 2^>nul^|mimised.runexe "s/.*http:\/\//http:\/\//g;s/\.swf\?.*/\.swf/g"') DO SET letv.in.swf=%%i
ECHO in : %letv.in.swf%
FOR /f %%i in ('echo %letv.in.swf%^|mimised.runexe "s/http:\/\/.*p\///g;s/\/new.*//g;s/\//./g"') DO set letv.in.swf.Date=%%i
MD "%runpath%letv\in\%letv.in.swf.date%">nul 2>nul
ECHO %letv.in.swf%>"%runpath%letv\in\%letv.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %letv.in.swf.date%
FOR /f %%i in ('echo %letv.in.swf%^|mimised.runexe "s/http:\/\/.*\///g"') DO set letv.in.swf.File=%%i
REM ECHO in.File : %letv.in.swf.File%
mimiwget.runexe --timeout=30 -c %letv.in.swf% -O "%runpath%letv\in\%letv.in.swf.date%\letv.in.%letv.in.swf.File%">nul 2>nul

REM 站外播放
REM http://i7.imgs.letv.com/player/swfPlayer.swf?autoPlay=0&id=2137231
REM http://img1.c0.letv.com/ptv/player/swfPlayer.swf?id=2137231
SET letv.out.swf=http://img1.c0.letv.com/ptv/player/swfPlayer.swf
ECHO out : %letv.out.swf%
REM FOR /f %%i in ('echo %letv.in.swf%^|mimised.runexe "s/http:\/\/.*p\///g;s/\/new.*//g;s/\//./g"') DO set letv.out.swf.Date=%%i
MD "%runpath%letv\out\now">nul 2>nul
ECHO %letv.out.swf%>"%runpath%letv\out\now\out.downlink.txt"
mimiwget.runexe --timeout=30 -c %letv.out.swf% -O "%runpath%letv\out\now\swfPlayer.swf">nul 2>nul

REM 站内直播
mimiwget.runexe --timeout=30 --spider http://player.hz.letv.com/live.swf 2>"%runpath%TempDown\letv.in.live.html"
FOR /f %%i in ('type "%runpath%TempDown\letv.in.live.html"^|findstr "Location:" 2^>nul^|mimised.runexe "s/Location:\s//g;s/?.*//g"') DO SET letv.in.live.swf=%%i
ECHO in.live : %letv.in.live.swf%
FOR /f %%i in ('echo %letv.in.live.swf%^|mimised.runexe "s/.*\.com\/p\///;s/\/new.*//g;s/\//./g"') DO set letv.in.live.swf.Date=%%i
MD "%runpath%letv\in.live\%letv.in.live.swf.Date%">nul 2>nul
ECHO %letv.in.live.swf%>"%runpath%letv\in.live\%letv.in.live.swf.Date%\in.live.downlink.txt"
FOR /f %%i in ('echo %letv.in.live.swf%^|mimised.runexe "s/.*\/newplayer\///g"') DO set letv.in.live.swf.File=%%i
mimiwget.runexe --timeout=30 -c %letv.in.live.swf% -O "%runpath%letv\in.live\%letv.in.live.swf.Date%\letv.in.live.%letv.in.live.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_iqiyi
REM 爱奇艺
DEL /q "%runpath%TempDown\iqiyi.in.html">nul 2>nul
DEL /q "%runpath%TempDown\iqiyi.out.html">nul 2>nul
DEL /q "%runpath%TempDown\iqiyi.in.live.html">nul 2>nul
ECHO 爱奇艺

REM 站内播放
mimiwget.runexe --timeout=30 -c "http://www.iqiyi.com/dianshiju/20110608/5549a1c66a33f8e3.html" -O "%runpath%TempDown\iqiyi.in.html">nul 2>nul
FOR /f "delims== tokens=2*" %%i in ('type "%runpath%TempDown\iqiyi.in.html"^|findstr "data-flashplayerparam-flashurl=.*\.swf" 2^>nul^|mimised.runexe "s/\""//g"') DO SET iqiyi.in.swf=%%i
ECHO in : %iqiyi.in.swf%
FOR /f %%i in ('echo %iqiyi.in.swf%^|mimised.runexe "s/http:.*flashplayer\///;s/\/.*//"') DO set iqiyi.in.swf.Date=%%i
MD "%runpath%iqiyi\in\%iqiyi.in.swf.date%">nul 2>nul
ECHO %iqiyi.in.swf%>"%runpath%iqiyi\in\%iqiyi.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %iqiyi.in.swf.date%
FOR /f %%i in ('echo %iqiyi.in.swf%^|mimised.runexe "s/http:.*flashplayer.*\///"') DO set iqiyi.in.swf.File=%%i
REM ECHO in.File : %iqiyi.in.swf.File%
mimiwget.runexe --timeout=30 -c %iqiyi.in.swf% -O "%runpath%iqiyi\in\%iqiyi.in.swf.date%\iqiyi.in.%iqiyi.in.swf.File%">nul 2>nul

REM 站外播放
mimiwget.runexe --timeout=30 --spider http://player.video.qiyi.com/606f7fc3719b4ab2a2133752497adddd/0/3693/dianshiju/20110608/5549a1c66a33f8e3.swf 2>"%runpath%TempDown\iqiyi.out.html"
FOR /f %%i in ('type "%runpath%TempDown\iqiyi.out.html"^|findstr "Location:" 2^>nul^|mimised.runexe "s/Location:\s//g;s/?.*//g"') DO SET iqiyi.out.swf=%%i
ECHO out : %iqiyi.out.swf%
FOR /f %%i in ('echo %iqiyi.out.swf%^|mimised.runexe "s/http:.*flashplayer\///;s/\/.*//"') DO set iqiyi.out.swf.Date=%%i
MD "%runpath%iqiyi\out\%iqiyi.out.swf.date%">nul 2>nul
ECHO %iqiyi.out.swf%>"%runpath%iqiyi\out\%iqiyi.out.swf.date%\out.downlink.txt"
REM ECHO out.date : %iqiyi.out.swf.date%
FOR /f %%i in ('echo %iqiyi.out.swf%^|mimised.runexe "s/http:.*flashplayer.*\///"') DO set iqiyi.out.swf.File=%%i
REM ECHO out.File : %iqiyi.out.swf.File%
mimiwget.runexe --timeout=30 -c %iqiyi.out.swf% -O "%runpath%iqiyi\out\%iqiyi.out.swf.date%\iqiyi.out.%iqiyi.out.swf.File%">nul 2>nul

REM 站内直播
mimiwget.runexe --timeout=30 -c "http://www.iqiyi.com/c_19rrgv1kfm/" -O "%runpath%TempDown\iqiyi.in.live.html">nul 2>nul
FOR /f "delims== tokens=2*" %%i in ('type "%runpath%TempDown\iqiyi.in.live.html"^|findstr "data-flashplayerparam-flashurl=.*\.swf" 2^>nul^|mimised.runexe "s/\""//g"') DO SET iqiyi.in.live.swf=%%i
ECHO in.live : %iqiyi.in.live.swf%
FOR /f %%i in ('echo %iqiyi.in.live.swf%^|mimised.runexe "s/http:.*flashplayer\///;s/\/.*//"') DO set iqiyi.in.live.swf.Date=%%i
MD "%runpath%iqiyi\in.live\%iqiyi.in.live.swf.date%">nul 2>nul
ECHO %iqiyi.in.live.swf%>"%runpath%iqiyi\in.live\%iqiyi.in.live.swf.date%\in.live.downlink.txt"
REM ECHO in.live.date : %iqiyi.in.live.swf.date%
FOR /f %%i in ('echo %iqiyi.in.live.swf%^|mimised.runexe "s/http:.*flashplayer.*\///"') DO set iqiyi.in.live.swf.File=%%i
REM ECHO in.live.File : %iqiyi.in.live.swf.File%
mimiwget.runexe --timeout=30 -c %iqiyi.in.live.swf% -O "%runpath%iqiyi\in.live\%iqiyi.in.live.swf.date%\iqiyi.in.live.%iqiyi.in.live.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_TimeToCheck
for /f "delims=:" %i in ('time/t') do if %i equ 3 echo ok
GOTO :TrueEND

:TrueEND
