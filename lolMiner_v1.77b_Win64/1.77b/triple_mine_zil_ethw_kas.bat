@echo off

setlocal enableDelayedExpansion

Rem #################################
Rem ## Begin of user-editable part ##
Rem #################################

set "ZILPOOL=eu1-zil.shardpool.io:3333"
set "ZILWALLET=zil12kfcrls87pzqnneratejhk8xa3wdzlhrdl7w5g"

set "ETHPOOL=ethw.2miners.com:2020"
set "ETHWALLET=0x155da78b788ab54bea1340c10a5422a8ae88142f"

set "KASPOOL=eu.acc-pool.pw:16064"
set "KASWALLET=kaspa:qqgsckw6auwxpne56c9jr7w645ef6tgkvaydadhlegwnaz7uv8haje9vdkzvq.lolMinerWorker"	

set "WORKER=lolMinerWorker"		
set "EXTRAPARAMETERS="							

Rem #################################
Rem ##  End of user-editable part  ##
Rem #################################


cd /d %~dp0

set MyVariable=%CD%\lolMiner.exe

:WindowsVer
echo "Running lolMiner from %MyVariable%"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
goto OtherW

:W10
"%MyVariable%" --algo ETHASH --pool !ZILPOOL! --user !ETHWALLET!.!WORKER! --pass !ZILWALLET!@!ETHPOOL! --enablezilcache --dualmode KASPADUAL --dualpool !KASPOOL! --dualuser !KASWALLET! --watchdog exit !EXTRAPARAMETERS!
if %ERRORLEVEL% == 42 (
	timeout 10
	goto W10
)
goto END

:OtherW
"%MyVariable%" --algo ETHASH --pool !ZILPOOL! --user !ETHWALLET!.!WORKER! --pass !ZILWALLET!@!ETHPOOL! --enablezilcache --dualmode KASPADUAL --dualpool !KASPOOL! --dualuser !KASWALLET!  --watchdog exit !EXTRAPARAMETERS! --nocolor
if %ERRORLEVEL% == 42 (
	timeout 10
	goto OtherW
)

:END
pause


