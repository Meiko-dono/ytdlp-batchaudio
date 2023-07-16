@echo off & setlocal
:: Change download directory in the line below
:: Make sure the path you set has the exact same format as the example given below, 
:: where \ytdl is the folder which contains all downloaded songs
::
set "dc=C:\CHANGEME\ytdl"
::	    ^^^^^^^^^^^^^^^^
::
::========================================================================
echo [NOTE]: Current download directory used: %dc%
echo [NOTE]: Make sure the correct directory is set inside the script before using!
echo ============================================================================================
:: Dev-Notes: For all occurences of 'cd' you may need /D switch in case the directory is in a different Drive
cd /D "%~dp0"
set /a plnr=0
set /p "url=Enter URL:"
set /p "goplaylist=Playlist? [y/n]:"
if /I not %goplaylist%==y goto format

:pl
if exist "%dc%\playlist_%plnr%\" (
	dir /A /B "%dc%\playlist_%plnr%" | findstr /R ".">NUL && GOTO newpl
) else (
	md %dc%\playlist_%plnr%
)
echo [STARTING DOWNLOAD]
yt-dlp -f ba -o "%dc%\playlist_%plnr%\%%(playlist_index)s_%%(title)s.%%(ext)s" %url%
cd /D "%dc%\playlist_%plnr%"
for %%i in (*.webm) do ffmpeg -i "%%i" -vn -c:a copy "%%~ni.ogg"
del /q *.webm
goto finish

:newpl
set /a plnr+=1 
goto pl

:format
set /p "goformat=Select format? [y/n]:"
if /I not %goformat%==y goto dl
yt-dlp -F %url%
set /p "vidformat=Select format to download [3 digits]:"
echo [STARTING DOWNLOAD]
yt-dlp -f %vidformat% -o "%dc%\%%(title)s.%%(ext)s" %url%
goto finish

:dl
echo [STARTING DOWNLOAD]
yt-dlp -f ba -o "%dc%\%%(title)s.%%(ext)s" %url%
echo ============================================================================================
set /p "convflag=This will convert ALL '.webm' files in your base directory (w/o subfolders) to '.ogg'. Proceed? [y/n]:"
if /I not %convflag%==y goto finish
cd /D "%dc%"
for %%i in (*.webm) do ffmpeg -i "%%i" -vn -c:a copy "%%~ni.ogg"
del /q *.webm

:finish
echo ===========================================================================
echo  ______   ______   ___ __ __   ______   __       ______   _________  ______      
echo /_____/\ /_____/\ /__//_//_/\ /_____/\ /_/\     /_____/\ /________/\/_____/\     
echo \:::__\/ \:::_ \ \\::\^| \^| \ \\:::_ \ \\:\ \    \::::_\/_\__.::.__\/\::::_\/_    
echo  \:\ \  __\:\ \ \ \\:.      \ \\:(_) \ \\:\ \    \:\/___/\  \.:\ \   \:\/___/\   
echo   \:\ \/_/\\:\ \ \ \\:.\-/\  \ \\: ___\/ \:\ \____\::___\/_  \::\ \   \::___\/_  
echo    \:\_\ \ \\:\_\ \ \\. \  \  \ \\ \ \    \:\/___/\\:\____/\  \::\ \   \:\____/\ 
echo     \_____\/ \_____\/ \__\/ \__\/ \_\/     \_____\/ \_____\/   \__\/    \_____\/ 
echo     =============================================================================
pause