[Setup]
AppName=BoomScape Launcher
AppPublisher=BoomScape
UninstallDisplayName=BoomScape
AppVersion=${project.version}
AppSupportURL=https://boom-scape.com/
DefaultDirName={localappdata}\BoomScape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/runelite_small.bmp
SetupIconFile=${basedir}/runelite.ico
UninstallDisplayIcon={app}\BoomScape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=BoomScapeSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\BoomScape.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\BoomScape.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\BoomScape\BoomScape"; Filename: "{app}\BoomScape.exe"
Name: "{userprograms}\BoomScape\BoomScape (configure)"; Filename: "{app}\BoomScape.exe"; Parameters: "--configure"
Name: "{userprograms}\BoomScape\BoomScape (safe mode)"; Filename: "{app}\BoomScape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\BoomScape"; Filename: "{app}\BoomScape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\BoomScape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\BoomScape.exe"; Description: "&Open BoomScape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\BoomScape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.runelite\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"