@echo off
setlocal enabledelayedexpansion
color 0b
title Universal Auto-Downloader Engine

:: ==========================================
:: 1. SETUP DIREKTORI PORTABEL
:: ==========================================
set "BASE_DIR=%~dp0"
set "BIN_DIR=!BASE_DIR!bin"
set "OUT_DIR=!BASE_DIR!Downloads"

if not exist "!BIN_DIR!" mkdir "!BIN_DIR!"
if not exist "!OUT_DIR!" mkdir "!OUT_DIR!"

cls
echo ==========================================================
echo         MEMERIKSA INTEGRITAS SISTEM
echo ==========================================================

:: Resolusi Dependensi (Tanpa blok visual untuk menekan delay)
if not exist "!BIN_DIR!\yt-dlp.exe" (
    curl -L -q -s -o "!BIN_DIR!\yt-dlp.exe" "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
)

if not exist "!BIN_DIR!\ffmpeg.exe" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip' -OutFile '!BIN_DIR!\ffmpeg.zip'"
    powershell -NoProfile -Command "Expand-Archive -Path '!BIN_DIR!\ffmpeg.zip' -DestinationPath '!BIN_DIR!\ffmpeg_temp' -Force"
    powershell -NoProfile -Command "Get-ChildItem -Path '!BIN_DIR!\ffmpeg_temp' -Filter *.exe -Recurse | Copy-Item -Destination '!BIN_DIR!' -Force"
    rmdir /S /Q "!BIN_DIR!\ffmpeg_temp"
    del /Q "!BIN_DIR!\ffmpeg.zip"
)

if not exist "!BIN_DIR!\deno.exe" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/denoland/deno/releases/latest/download/deno-x86_64-pc-windows-msvc.zip' -OutFile '!BIN_DIR!\deno.zip'"
    powershell -NoProfile -Command "Expand-Archive -Path '!BIN_DIR!\deno.zip' -DestinationPath '!BIN_DIR!\deno_temp' -Force"
    powershell -NoProfile -Command "Get-ChildItem -Path '!BIN_DIR!\deno_temp' -Filter *.exe -Recurse | Copy-Item -Destination '!BIN_DIR!' -Force"
    rmdir /S /Q "!BIN_DIR!\deno_temp"
    del /Q "!BIN_DIR!\deno.zip"
)

set "PATH=!BIN_DIR!;%PATH%"

:: ==========================================
:: 2. PROGRAM UTAMA
:: ==========================================
:start
cls
echo ==========================================================
echo       YOUTUBE ^& SOUNDCLOUD DOWNLOADER (PORTABLE) 
echo ==========================================================
echo   Output : !OUT_DIR!
echo   Dev    : abriel wiradika utama
echo ==========================================================
echo.

echo [1] Download Audio (Original/M4A) - YouTube/SoundCloud
echo [2] Download Video (Highest Quality) - YouTube
echo.
set /p pilihan=" [?] Pilih nomor (1/2): "
echo.
set /p link=" [?] Masukkan Link YouTube atau SoundCloud: "

echo.
echo  [i] Sedang memproses...
echo ----------------------------------------------------------

:: Rute Eksekusi GOTO (Mencegah Crash pada Kurung Kurawal/IF Block)
if "!pilihan!"=="1" goto dl_audio
if "!pilihan!"=="2" goto dl_video

echo [x] Pilihan tidak valid!
timeout /t 2 >nul
goto start

:dl_audio
"!BIN_DIR!\yt-dlp.exe" -f "ba" -x --audio-format m4a --ffmpeg-location "!BIN_DIR!" -o "!OUT_DIR!\%%(title)s.%%(ext)s" --no-cache-dir --restrict-filenames --windows-filenames --add-metadata --embed-thumbnail --keep-video --remote-components ejs:github "!link!"
goto cek_status

:dl_video
"!BIN_DIR!\yt-dlp.exe" -f "bv+ba/b" --ffmpeg-location "!BIN_DIR!" -o "!OUT_DIR!\%%(title)s.%%(ext)s" --no-cache-dir --restrict-filenames --windows-filenames --add-metadata --embed-thumbnail --keep-video --remote-components ejs:github "!link!"
goto cek_status

:cek_status
echo ----------------------------------------------------------
if !errorlevel! equ 0 (
    echo  [v] BERHASIL! File disimpan di folder Downloads.
) else (
    echo  [x] TERJADI KESALAHAN!
)
echo ----------------------------------------------------------
echo.

set /p lagi=" [?] Ingin download lagi? (y/n): "
if /i "!lagi!"=="y" goto start

echo Terima kasih -abriel !
pause
exit