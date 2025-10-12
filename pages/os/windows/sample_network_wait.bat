:Wifi
wpeinit.exe
net start WlanSvc
netsh wlan add profile filename=%SystemDrive%\wifi.xml
netsh wlan connect name=SSIDHERE

REM Pause for a few seconds to allow wifi to connect before the first test
ping 127.0.0.1 -n 6

:PingTest
ping -n 1 8.8.8.8 | find "TTL=" >nul
if errorlevel 1 (
    goto WaitForAMoment

) else (
    goto Connected
)

:WaitForAMoment
ping 127.0.0.1 -n 6 >nul REM wait for 5 seconds
goto :PingTest

:Connected
REM Add command here such as http imaging UI, MDT, etc
REM net use Y: \\server\Share /USER:netuser
REM X:\setup.exe
cmd.exe