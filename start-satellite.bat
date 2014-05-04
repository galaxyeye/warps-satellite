@echo off
echo starting satellite system ...

echo test phantomjs :  if you can see a file downloaded and saved uder output\wwwroot\{current-data}\ folder, it means the test is passed

start /B .\bin\phantomjs .\src\client.js http://www.baidu.com/ > nul

echo start proxy servers ...
start /B .\bin\phantomjs --load-images=false .\src\coordinator.js start > nul

echo open satellite controller ...
rem sleep for 5 seconds
ping -n 5 127.0.0.1 > nul
start /B http://127.0.0.1:19180/

:Loop
:Help
echo:
echo:
echo ---------------------------------
echo help : 
echo 1) help - print this help message
echo 2) pps - list phatonjs processes
echo 3) start - start all proxy servers, the servers are started by default, so call this only if you called stop first
echo 4) stop - stop all proxy servers, but the satellite system is still running
echo 5) restart - restart all proxy servers
echo 6) exit - exit the satellite system

set /P command=satellite:
echo:
if "%command%"=="help" goto Help
if "%command%"=="pps" goto Pps
if "%command%"=="start" goto Start
if "%command%"=="stop" goto Stop
if "%command%"=="restart" goto Restart
if "%command%"=="exit" goto Exit
goto Loop
:Pps
tasklist /fi "Imagename eq phantomjs.exe"
echo:
echo total : 
tasklist /fi "Imagename eq phantomjs.exe" | find /i /n /c "phantomjs.exe"
echo processes
goto Loop
:Start
start /B http://127.0.0.1:19180/start
goto Loop
:Stop
start /B http://127.0.0.1:19180/stop
goto Loop
:Restart
start /B http://127.0.0.1:19180/restart
goto Loop
:Exit
taskkill /im phantomjs.exe /t
echo wait for 5 seconds ...

	set /a retry = 1;
	:Exiting
	rem sleep for 5 seconds
	ping -n 5 127.0.0.1 > nul
	tasklist /fi "Imagename eq phantomjs.exe" 2>nul | find /i /n "phantomjs.exe" > nul
	if %ERRORLEVEL% equ 0 if %retry% leq 3 (
		echo still running, retry ...
		taskkill /im phantomjs.exe /t > nul
		set /a retry=retry+1
		goto Exiting
	)

	if %retry% gtr 3 (
		rem force kill all phantomjs processes
		taskkill /im phantomjs.exe /f /t	
	)

echo Bye bye!!