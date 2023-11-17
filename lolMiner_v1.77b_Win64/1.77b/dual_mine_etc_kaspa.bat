@echo off

setlocal enableDelayedExpansion

Rem #################################
Rem ## Begin of user-editable part ##
Rem #################################

set "POOL=etc.2miners.com:1010"
set "WALLET=0x155da78b788ab54bea1340c10a5422a8ae88142f"

set "KASPAPOOL=acc-pool.pw:16061"
set "KASPAWALLET=kaspa:qzhfnqfz5xtx2sgdf52aahaw6nkmda8p84rknut25lt82pnd9y82ke0em7s5j"
							
set "WORKER=lolMinerWorker"

set "EXTRAPARAMETERS=--apiport 8020"

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
"%MyVariable%" --algo ETCHASH --pool !POOL! --user !WALLET! --worker !WORKER! --dualmode KASPADUAL --dualpool !KASPAPOOL! --dualuser !KASPAWALLET! --dualworker !WORKER! !EXTRAPARAMETERS! --watchdog exit
timeout 10
goto W10
goto END

:OtherW
"%MyVariable%" --algo ETCHASH --pool !POOL! --user !WALLET! --worker !WORKER! --dualmode KASPADUAL --dualpool !KASPAPOOL! --dualuser !KASPAWALLET! --dualworker !WORKER! !EXTRAPARAMETERS! --watchdog exit --nocolor
timeout 10
goto OtherW

:END
pause
