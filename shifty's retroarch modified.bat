@echo off
setlocal enableDelayedExpansion
 
:: Shifty's RetroArch Playlist Script
::
:: This script will create per-system ROM playlists, the files used to display system columns in the RetroArch XMB UI
:: It exists to work around the romset checksumming that is forced in the current (1.2.2 at time of writing) build of RetroArch
:: Put simply, this will let you create playlists with ROMs that the Add Content > Scan Directory/File process would usually ignore
::
:: WARNING: This script is not compatible with the Add Content > Scan Directory/File process
:: It will erase existing playlists as part of the generation process, so make sure to back them up beforehand if necessary
 
:: Change these to point to your RetroArch and top-level ROM directories
set RADir=C:\Users\aerga\OneDrive\Consoles\RetroArch
set ROMDir=\\SKYWARP\Console
 
:: For each RetroArch core, add one of these blocks below:
:: set RomDirs[n]=
:: set CoreLibs[n]=
:: set CoreNames[n]=
:: set PlaylistNames[n]=
:: set SupportedExtensions[n]=
::
:: The numbers in square brackets need to start at 0, and be incremented by 1 for each block added
:: RomDirs[n] should be set to the ROM subdirectory for this core (ex. "SNES" will cause the script to scan ROMDir\SNES)
:: CoreLibs[n] should be set to the core's DLL filename (in RetroArch\cores)
:: CoreNames[n] should be set to the human-readable name of the RetroArch core (bracketed names in the RetroArch 'Load Core' menu)
:: PlaylistNames[n] should be set to the RetroArch name of this core's platform (look at the icon filenames in RetroArch\assets\xmb\monochrome\png\)
:: SupportedExtensions[n] should be set to the supported extensions for this core, prefixed with the wildcard (*) character (available in the RetroArch Information -> Core Info menu)
::
:: Example Config
:: The config below will create playlist files for SNES, MegaDrive/Genesis and Sega Master System ROMs
::
 
set RomDirs[0]=GW
set PlaylistNames[0]=Nintendo - Game and Watch
set SupportedExtensions[0]=*.mgw
 
set RomDirs[1]=GB
set PlaylistNames[1]=Nintendo - Game Boy
set SupportedExtensions[1]=*.gb
 
set RomDirs[2]=GBA
set PlaylistNames[2]=Nintendo - Game Boy Advance
set SupportedExtensions[2]=*.gba
 
set RomDirs[3]=GBC
set PlaylistNames[3]=Nintendo - Game Boy Color
set SupportedExtensions[3]=*.gbc
 
set RomDirs[4]=MAME
set PlaylistNames[4]=Arcade (various)
set SupportedExtensions[4]=*.zip *.chd *.7z
 
set RomDirs[5]=MASTERSYSTEM
set PlaylistNames[5]=Sega - Master System - Mark III
set SupportedExtensions[5]=*.sms
 
set RomDirs[6]=MEGADRIVE
set PlaylistNames[6]=Sega - Mega Drive - Genesis
set SupportedExtensions[6]=*.smd
 
set RomDirs[7]=N64
set PlaylistNames[7]=Nintendo - Nintendo 64
set SupportedExtensions[7]=*.n64
 
set RomDirs[8]=NDS
set PlaylistNames[8]=Nintendo - Nintendo DS Decrypted
set SupportedExtensions[8]=*.nds
 
set RomDirs[9]=NES
set PlaylistNames[9]=Nintendo - Nintendo Entertainment System
set SupportedExtensions[9]=*.nes
 
set RomDirs[10]=ports
set PlaylistNames[10]=DOOM
set SupportedExtensions[10]=*.wad
 
set RomDirs[11]=PSP
set PlaylistNames[11]=Sony - PlayStation Portable
set SupportedExtensions[11]=*.iso
 
set RomDirs[12]=PSX
set PlaylistNames[12]=Sony - PlayStation
set SupportedExtensions[12]=*.cue
 
set RomDirs[13]=SEGA32X
set PlaylistNames[13]=Sega - 32X
set SupportedExtensions[13]=*.32x
 
set RomDirs[14]=SEGACD
set PlaylistNames[14]=Sega - CD
set SupportedExtensions[14]=*.cue
 
set RomDirs[15]=SNES
set PlaylistNames[15]=Nintendo - Super Nintendo Entertainment System
set SupportedExtensions[15]=*.sfc
 
REM set RomDirs[]=
REM set PlaylistNames[]=
REM set SupportedExtensions[]=*.
 
:: You can safely ignore everything below here.
echo ============================================
echo Shifty's RetroArch Playlist Script
echo ============================================
echo.
echo Configured Playlists:
 
set "x=0"
:InfoLoop
if defined RomDirs[%x%] (
        echo !PlaylistNames[%x%]!
 
    set /a "x+=1"
    GOTO :InfoLoop
)
 
echo.
 
PAUSE
 
echo.
 
set "x=0"
 
:MainLoop
if defined RomDirs[%x%] (
        echo ============================================
        echo !PlaylistNames[%x%]!
        echo ============================================
 
        del "%RADir%\playlists\!PlaylistNames[%x%]!.lpl";
        echo Deleted %RADir%\playlists\!PlaylistNames[%x%]!.lpl
        echo.
 
        echo Entering %ROMDir%\!RomDirs[%x%]!
        echo.
        echo Adding:
 
        pushd "%ROMDir%\!RomDirs[%x%]!"
        for /R %%f in (!SupportedExtensions[%x%]!) do (
                echo %%~nf%%~xf
                (
					echo %ROMDIR%%%~pf%%~nf%%~xf
					echo %%~nf
					echo DETECT
					echo DETECT
					echo 0^|crc
					echo !PlaylistNames[%x%]!.lpl
                ) >> "%RADir%\playlists\!PlaylistNames[%x%]!.lpl"
        )
        popd
 
        echo.
        echo Writing %RADir%\playlists\!PlaylistNames[%x%]!.lpl
        echo. >> "%RADir%\playlists\!PlaylistNames[%x%]!.lpl"
 
        echo.
 
    set /a "x+=1"
    GOTO :MainLoop
)
 
PAUSE