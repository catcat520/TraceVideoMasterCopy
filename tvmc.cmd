@ECHO OFF
CLS
:StartTrace
set runpath=%~dp0
path %path%;%runpath%mimiLIB
MD "%runpath%TempDown">nul 2>nul
MD "%runpath%iqiyi">nul 2>NUL
MD "%runpath%letv">nul 2>NUL
MD "%runpath%youku">nul 2>nul
CALL :FUN_iqiyi
CALL :FUN_letv
CALL :FUN_youku
CALL :FUN_sohu
CALL :FUN_qq
CALL :FUN_tudou
CALL :FUN_pptv
CALL :FUN_17173
REM CALL :FUN_ku6 dbing
REM CALL :FUN_56 dbing
REM CALL :FUN_pps dbing
title VER:2015.09.24.29 TraceVideoMasterCopy , 跟踪和记录原始的影音网页内容
SET/p echoloop=离下次检测还有 : <NUL
REM 2h=7200s 4h=14400s 8h=28800s
mimitimeout.runexe /t 14400 /nobreak
GOTO :StartTrace

:FUN_youku
REM 优酷
DEL /q "%runpath%TempDown\youku.in.html">nul 2>nul
DEL /q "%runpath%TempDown\youku.out.loader.html">nul 2>NUL
DEL /q "%runpath%TempDown\youku.out.player.html">nul 2>nul
ECHO 优酷 uptime : %date%%time%

REM 站内播放
REM 播放器.swf
mimiwget.runexe --timeout=30 -c http://v.youku.com/v_show/id_XNzYxNzM0MDk2.html -O "%runpath%TempDown\youku.in.player.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\youku.in.player.html"^|findstr "playerUrl" 2^>nul^|mimised.runexe "s/.*http/http/g;s/\.swf.*;/.swf/g"') DO SET youku.in.player.swf=%%i
ECHO in.player.swf : %youku.in.player.swf%
FOR /f %%i in ('echo %youku.in.player.swf%^|mimised.runexe "s/.*com\/v//g;s/\/v.*//g"') DO set youku.in.player.swf.Date=%%i
MD "%runpath%youku\in\%youku.in.player.swf.date%">nul 2>nul
ECHO %youku.in.player.swf%>"%runpath%youku\in\%youku.in.player.swf.date%\in.player.downlink.txt"
REM ECHO in.date : %youku.in.player.swf.Date%
FOR /f %%i in ('echo %youku.in.player.swf%^|mimised.runexe "s/.*swf\///g;s/\.swf.*/.swf/g"') DO set youku.in.player.swf.File=%%i
REM ECHO in.player.File : %youku.in.player.swf.File%
mimiwget.runexe --timeout=30 -c %youku.in.player.swf% -O "%runpath%youku\in\%youku.in.player.swf.date%\youku.in.%youku.in.player.swf.File%">nul 2>NUL

REM 站外播放
REM 调用.swf
mimiwget.runexe --timeout=30 -c http://v.youku.com/v_show/id_XMTI1ODc5MjU2NA==.html -O "%runpath%TempDown\youku.out.loader.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\youku.out.loader.html"^|findstr "playerUrl" 2^>nul^|mimised.runexe "s/.*http/http/g;s/\.swf.*;/.swf/g"') DO SET youku.out.loader.swf=%%i
ECHO out.loader.swf : %youku.out.loader.swf%
FOR /f %%i in ('echo %youku.out.loader.swf%^|mimised.runexe "s/.*com\/v//g;s/\/v.*//g"') DO set youku.out.loader.swf.Date=%%i
MD "%runpath%youku\out\%youku.out.loader.swf.date%">nul 2>nul
ECHO %youku.out.loader.swf%>"%runpath%youku\out\%youku.out.loader.swf.date%\out.loader.downlink.txt"
REM ECHO out.date : %youku.out.loader.swf.Date%
FOR /f %%i in ('echo %youku.out.loader.swf%^|mimised.runexe "s/.*swf\///g;s/\.swf.*/.swf/g"') DO set youku.out.loader.swf.File=%%i
REM ECHO out.loader.File : %youku.out.loader.swf.File%
mimiwget.runexe --timeout=30 -c %youku.out.loader.swf% -O "%runpath%youku\out\%youku.out.loader.swf.date%\youku.out.%youku.out.loader.swf.File%">nul 2>NUL

REM 站外播放
REM 播放器.swf
mimiwget.runexe --timeout=30 -c http://www.youku.com/show_page/id_zaf02ac580b5711e5a080.html -O "%runpath%TempDown\youku.out.player.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\youku.out.player.html"^|findstr "player:" 2^>nul^|mimised.runexe "s/.*http:/http:/g;s/\.swf.*/.swf/g"') DO SET youku.out.player.swf=%%i
ECHO out.player.swf : %youku.out.player.swf%
FOR /f %%i in ('echo %youku.out.player.swf%^|mimised.runexe "s/.*com\/v//g;s/\/v.*//g"') DO set youku.out.player.swf.Date=%%i
MD "%runpath%youku\out\%youku.out.player.swf.date%">nul 2>nul
ECHO %youku.out.player.swf%>"%runpath%youku\out\%youku.out.player.swf.date%\out.player.downlink.txt"
REM ECHO out.date : %youku.out.player.swf.Date%
FOR /f %%i in ('echo %youku.out.player.swf%^|mimised.runexe "s/.*swf\///g;s/\.swf.*/.swf/g"') DO set youku.out.player.swf.File=%%i
REM ECHO out.File : %youku.out.player.swf.File%
mimiwget.runexe --timeout=30 -c %youku.out.player.swf% -O "%runpath%youku\out\%youku.out.player.swf.date%\youku.out.%youku.out.player.swf.File%">nul 2>NUL
GOTO :TrueEND

:FUN_tudou
REM 土豆
DEL /q "%runpath%TempDown\tudou.in.html">nul 2>nul
ECHO 土豆 uptime : %date%%time%

REM 站内播放
mimiwget.runexe --timeout=30 -c "http://www.tudou.com/albumplay/HzK-zOzBjxo/tPHBZ9xQGmU.html" -O "%runpath%TempDown\tudou.in.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\tudou.in.html"^|findstr ",playerUrl:" 2^>nul^|sed "s/.*http/http/g;s/\.swf.*/\.swf/g"') DO SET tudou.in.swf=%%i
ECHO in : %tudou.in.swf%
FOR /f %%i in ('echo %tudou.in.swf%^|mimised.runexe "s/.*PortalPlayer_//g;s/\.swf.*//g"') DO set tudou.in.swf.Date=%%i
MD "%runpath%tudou\in\%tudou.in.swf.date%">nul 2>NUL
ECHO %tudou.in.swf%>"%runpath%tudou\in\%tudou.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %tudou.in.swf.date%
FOR /f %%i in ('echo %tudou.in.swf%^|mimised.runexe "s/.*Main\.swf.*/Main.swf/g"') DO set tudou.in.swf.File=PortalPlayer.swf
REM ECHO in.File : %tudou.in.swf.File%
mimiwget.runexe --timeout=30 -c %tudou.in.swf% -O "%runpath%tudou\in\%tudou.in.swf.date%\tudou.in.%tudou.in.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_qq
REM QQ
ECHO 腾讯 uptime : %date%%time%

REM 站内播放
ECHO in : http://imgcache.qq.com/tencentvideo_v1/player/TencentPlayer.swf
MD "%runpath%qq\in\">nul 2>NUL
mimiwget.runexe --timeout=30 -c "http://imgcache.qq.com/tencentvideo_v1/player/TencentPlayer.swf" -O "%runpath%qq\in\qq.in.player.swf">nul 2>NUL

REM 站内播放
ECHO out : http://static.video.qq.com/TPout.swf
MD "%runpath%qq\out\">nul 2>NUL
mimiwget.runexe --timeout=30 -c "http://static.video.qq.com/TPout.swf" -O "%runpath%qq\out\qq.out.player.swf">nul 2>nul
GOTO :TrueEND

:FUN_sohu
REM 搜狐
DEL /q "%runpath%TempDown\sohu.in.html">nul 2>nul
ECHO 搜狐 uptime : %date%%time%

REM 站内播放
mimiwget.runexe --timeout=30 -c "http://tv.sohu.com/20090316/n262826768.shtml" -O "%runpath%TempDown\sohu.in.html">nul 2>nul
FOR /f %%i in ('type "%runpath%TempDown\sohu.in.html"^|findstr ".swf"^|findstr "tv"^|findstr "swf/2"^|findstr "^vrs" 2^>nul^|mimised.runexe "s/.*http/http/g;s/Main\..*/Main.swf/g"') DO SET sohu.in.swf=%%i
ECHO in : %sohu.in.swf%
FOR /f %%i in ('echo %sohu.in.swf%^|mimised.runexe "s/.*http/http/g;s/\/Main\..*//g;s/.*\/swf\///g"') DO set sohu.in.swf.Date=%%i
MD "%runpath%sohu\in\%sohu.in.swf.date%">nul 2>NUL
ECHO %sohu.in.swf%>"%runpath%sohu\in\%sohu.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %sohu.in.swf.date%
FOR /f %%i in ('echo %sohu.in.swf%^|mimised.runexe "s/.*Main\.swf.*/Main.swf/g"') DO set sohu.in.swf.File=%%i
REM ECHO in.File : %letv.in.swf.File%
mimiwget.runexe --timeout=30 -c %sohu.in.swf% -O "%runpath%sohu\in\%sohu.in.swf.date%\sohu.in.%sohu.in.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_letv
REM 乐视
DEL /q "%runpath%TempDown\letv.in.html">nul 2>nul
DEL /q "%runpath%TempDown\letv.out.html">nul 2>nul
DEL /q "%runpath%TempDown\letv.in.live.html">nul 2>nul
ECHO 乐视 uptime : %date%%time%

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
mimiwget.runexe --timeout=30 --spider http://player.hz.letv.com/live.swf/open 2>"%runpath%TempDown\letv.in.live.html"
FOR /f %%i in ('type "%runpath%TempDown\letv.in.live.html"^|findstr "Location:" 2^>nul^|mimised.runexe "s/Location:\s//g;s/?.*//g"') DO SET letv.in.live.swf=%%i
ECHO in.live : %letv.in.live.swf%
FOR /f %%i in ('echo %letv.in.live.swf%^|mimised.runexe "s/.*\.com\/.*_p\///;s/\/new.*//g;s/\//./g"') DO set letv.in.live.swf.Date=%%i
MD "%runpath%letv\in.live\%letv.in.live.swf.Date%">nul 2>nul
ECHO %letv.in.live.swf%>"%runpath%letv\in.live\%letv.in.live.swf.Date%\in.live.downlink.txt"
FOR /f %%i in ('echo %letv.in.live.swf%^|mimised.runexe "s/.*\/newplayer\///g"') DO set letv.in.live.swf.File=%%i
mimiwget.runexe --timeout=30 -c %letv.in.live.swf% -O "%runpath%letv\in.live\%letv.in.live.swf.Date%\letv.in.live.%letv.in.live.swf.File%">nul 2>nul
GOTO :TrueEND

REM 站内直播 稳定旧版本
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
ECHO 爱奇艺 uptime : %date%%time%

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

:FUN_pptv
REM 聚力
DEL /q "%runpath%TempDown\pptv.in.html">nul 2>nul
DEL /q "%runpath%TempDown\pptv.in.live.html">nul 2>nul
ECHO 聚力 uptime : %date%%time%

REM 站内播放
mimiwget.runexe --timeout=30 --spider "http://player.pptv.com/v/F21k41IlHFq9O6M.swf" 2>"%runpath%TempDown\pptv.in.html"
FOR /f %%i in ('type "%runpath%TempDown\pptv.in.html"^|findstr "Location:" 2^>nul^|mimised.runexe "s/.*http:/http:/g;s/\.swf.*/\.swf/g"') DO SET pptv.in.swf=%%i
ECHO in : %pptv.in.swf%
FOR /f %%i in ('echo %pptv.in.swf%^|mimised.runexe "s/.*ikan\///g;s/\/.*//g"') DO set pptv.in.swf.Date=%%i
MD "%runpath%pptv\in\%pptv.in.swf.date%">nul 2>nul
ECHO %pptv.in.swf%>"%runpath%pptv\in\%pptv.in.swf.date%\in.downlink.txt"
REM ECHO in.date : %pptv.in.swf.date%
FOR /f %%i in ('echo %pptv.in.swf%^|mimised.runexe "s/.*[0-9]\///g"') DO set pptv.in.swf.File=%%i
REM ECHO in.File : %pptv.in.swf.File%
mimiwget.runexe --timeout=30 -c %pptv.in.swf% -O "%runpath%pptv\in\%pptv.in.swf.date%\pptv.in.%pptv.in.swf.File%">nul 2>nul

REM 站内直播
mimiwget.runexe --timeout=30 --spider "http://player.pptv.com/v/g1W0MpoAcK4Rjicc.swf" 2>"%runpath%TempDown\pptv.in.live.html"
FOR /f %%i in ('type "%runpath%TempDown\pptv.in.live.html"^|findstr "Location:" 2^>nul^|mimised.runexe "s/.*http:/http:/g;s/\.swf.*/\.swf/g"') DO SET pptv.in.live.swf=%%i
ECHO in.live : %pptv.in.live.swf%
FOR /f %%i in ('echo %pptv.in.live.swf%^|mimised.runexe "s/.*live\///g;s/\/.*//g"') DO set pptv.in.live.swf.Date=%%i
MD "%runpath%pptv\in.live\%pptv.in.live.swf.date%">nul 2>nul
ECHO %pptv.in.live.swf%>"%runpath%pptv\in.live\%pptv.in.live.swf.date%\in.live.downlink.txt"
REM ECHO in.live.date : %pptv.in.live.swf.date%
FOR /f %%i in ('echo %pptv.in.live.swf%^|mimised.runexe "s/.*[0-9]\///g"') DO set pptv.in.live.swf.File=%%i
REM ECHO in.live.File : %pptv.in.live.swf.File%
mimiwget.runexe --timeout=30 -c %pptv.in.live.swf% -O "%runpath%pptv\in.live\%pptv.in.live.swf.date%\pptv.in.live.%pptv.in.live.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_17173
REM 17173
DEL /q "%runpath%TempDown\17173.in.html">nul 2>nul
DEL /q "%runpath%TempDown\17173.in.live.html">nul 2>NUL
DEL /q "%runpath%TempDown\17173.out.html">nul 2>nul
DEL /q "%runpath%TempDown\17173.out.live.html">nul 2>nul
ECHO 17173 uptime : %date%%time%

REM 站内点播
mimiwget.runexe --timeout=30 -c "http://v.17173.com/v_1_121/Mjc1NjAxMTQ.html" -O "%runpath%TempDown\17173.in.html">nul 2>nul
FOR /f "delims==" %%i in ('type "%runpath%TempDown\17173.in.html"^|findstr "swfVersion" 2^>nul') DO SET I7173.in.swf=%%i
FOR /f %%i in ('echo %I7173.in.swf%^|mimised.runexe "s/.*:\s'//g;s/'.*//g"') DO set I7173.in.swf.Date=%%i
FOR /f %%i in ('echo %I7173.in.swf%^|mimised.runexe "s/.*:\s'//g;s/'.*//g"') DO set I7173.out.swf.Date=%%i
MD "%runpath%17173\in\%I7173.in.swf.date%">nul 2>NUL
MD "%runpath%17173\out\%I7173.out.swf.date%">nul 2>nul
SET I7173.in.swf=http://f.v.17173cdn.com/%I7173.in.swf.date%/flash/Player_file.swf
SET I7173.out.swf=http://f.v.17173cdn.com/%I7173.out.swf.date%/flash/Player_file_out.swf
ECHO %I7173.in.swf%>"%runpath%17173\in\%I7173.in.swf.date%\in.downlink.txt"
ECHO %I7173.out.swf%>"%runpath%17173\out\%I7173.out.swf.date%\out.downlink.txt"
ECHO in : %I7173.in.swf%
ECHO out : %I7173.out.swf%
REM ECHO in.date : %I7173.in.swf.date%
FOR /f %%i in ('echo %I7173.in.swf%^|mimised.runexe "s/.*\///g"') DO set I7173.in.swf.File=%%i
FOR /f %%i in ('echo %I7173.out.swf%^|mimised.runexe "s/.*\///g"') DO set I7173.out.swf.File=%%i
REM ECHO in.File : %I7173.in.swf.File%
mimiwget.runexe --timeout=30 -c %I7173.in.swf% -O "%runpath%17173\in\%I7173.in.swf.date%\17173.in.%I7173.in.swf.File%">nul 2>nul
mimiwget.runexe --timeout=30 -c %I7173.out.swf% -O "%runpath%17173\out\%I7173.out.swf.date%\17173.out.%I7173.out.swf.File%">nul 2>nul

REM 站内直播
mimiwget.runexe --timeout=30 -c "http://v.17173.com/live/list/liveHall.htm" -O "%runpath%TempDown\17173.in.live.html">nul 2>nul
FOR /f "delims=:" %%i in ('type "%runpath%TempDown\17173.in.live.html"^|findstr "swfVersion" 2^>nul') DO SET I7173.in.live.swf=%%i
REM ECHO %I7173.in.live.swf%
FOR /f %%i in ('echo %I7173.in.live.swf%^|mimised.runexe "s/.*\s'//g;s/'.*//g"') DO set I7173.in.live.swf.Date=%%i
MD "%runpath%17173\in.live\%I7173.in.live.swf.date%">nul 2>NUL
SET I7173.in.live.swf=http://f.v.17173cdn.com/%I7173.in.live.swf.date%/flash/Pad.swf
ECHO %I7173.in.live.swf%>"%runpath%17173\in.live\%I7173.in.live.swf.date%\in.live.downlink.txt"
ECHO in.live : %I7173.in.live.swf%
REM ECHO in.live.date : %I7173.in.live.swf.date%
FOR /f %%i in ('echo %I7173.in.live.swf%^|mimised.runexe "s/.*\///g"') DO set I7173.in.live.swf.File=%%i
REM ECHO in.live.File : %I7173.in.live.swf.File%
mimiwget.runexe --timeout=30 -c %I7173.in.live.swf% -O "%runpath%17173\in.live\%I7173.in.live.swf.date%\17173.in.live.%I7173.in.live.swf.File%">nul 2>nul
GOTO :TrueEND

:FUN_TimeToCheck
for /f "delims=:" %i in ('time/t') do if %i equ 3 echo ok
GOTO :TrueEND

:TrueEND
