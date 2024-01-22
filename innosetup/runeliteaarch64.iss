[Setup]
AppName=EternalScape Launcher
AppPublisher=EternalScape
UninstallDisplayName=EternalScape
AppVersion=${project.version}
AppSupportURL=https://boom-scape.com/
DefaultDirName={localappdata}\EternalScape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/runelite_small.bmp
SetupIconFile=${basedir}/runelite.ico
UninstallDisplayIcon={app}\EternalScape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=EternalScapeSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\EternalScape.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\EternalScape.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\EternalScape\EternalScape"; Filename: "{app}\EternalScape.exe"
Name: "{userprograms}\EternalScape\EternalScape (configure)"; Filename: "{app}\EternalScape.exe"; Parameters: "--configure"
Name: "{userprograms}\EternalScape\EternalScape (safe mode)"; Filename: "{app}\EternalScape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\EternalScape"; Filename: "{app}\EternalScape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\EternalScape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\EternalScape.exe"; Description: "&Open EternalScape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\EternalScape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.runelite\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"