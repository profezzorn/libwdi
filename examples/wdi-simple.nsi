; This examples demonstrates how libwdi can be used in an installer script
; to automatically install USB drivers along with your application.
;
; Requirements: Nullsoft Scriptable Install System (http://nsis.sourceforge.net/)
;
; To use this script, do the following:
; - configure libwdi (see config.h)
; - compile wdi-simple.exe
; - customize this script (application strings, wdi-simple.exe parameters, etc.)
; - open this script with Nullsoft Scriptable Install System
; - compile and run

; Use modern interface
  !include MUI2.nsh
  !define MUI_FINISHPAGE_NOAUTOCLOSE

; General
  Name                  "Proffie STM32 Bootloader driver"
  OutFile               "proffie-dfu-setup.exe"
  InstallDir            $PROGRAMFILES\proffie-dfu-setup
  InstallDirRegKey      HKLM "Software\proffie-dfu-setup" "Install_Dir"
  ShowInstDetails       show
  RequestExecutionLevel admin

; Pages
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_INSTFILES 
  !insertmacro MUI_UNPAGE_FINISH

;Languages
  !insertmacro MUI_LANGUAGE "English"

; Installer
Section "proffie-dfu-setup" SecDummy
  SetOutPath $INSTDIR
  File "wdi-simple.exe"
  WriteRegStr HKLM SOFTWARE\proffie-dfu-setup "Install_Dir" "$INSTDIR"
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\proffie-dfu-setup" "DisplayName" "libwdi example"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\proffie-dfu-setup" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\proffie-dfu-setup" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\proffie-dfu-setup" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
SectionEnd

; Call wdi-simple
;
; -n, --name <name>          set the device name
; -f, --inf <name>           set the inf name
; -m, --manufacturer <name>  set the manufacturer name
; -v, --vid <id>             set the vendor ID (VID)
; -p, --pid <id>             set the product ID (PID)
; -i, --iid <id>             set the interface ID (MI)
; -t, --type <driver_type>   set the driver to install
;                            (0=WinUSB, 1=libusb0, 2=libusbK, 3=usbser, 4=custom)
; -d, --dest <dir>           set the extraction directory
; -x, --extract              extract files only (don't install)
; -c, --cert <certname>      install certificate <certname> from the
;                            embedded user files as a trusted publisher
;     --stealth-cert         installs certificate above without prompting
; -s, --silent               silent mode
; -b, --progressbar=[HWND]   display a progress bar during install
;                            an optional HWND can be specified
; -o, --timeout              set timeout (in ms) to wait for any 
;                            pending installations
; -l, --log                  set log level (0=debug, 4=none)
; -h, --help                 display usage
Section "wdi-simple"
  DetailPrint "Running $INSTDIR\wdi-simple.exe"
  nsExec::ExecToLog '"$INSTDIR\wdi-simple.exe" --name "STM32  BOOTLOADER" --vid 0x0483 --pid 0xdf11 --progressbar=$HWNDPARENT --timeout 120000 -t0'
SectionEnd

; Uninstaller
Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\proffie-dfu-setup"
  DeleteRegKey HKLM SOFTWARE\proffie-dfu-setup
  Delete $INSTDIR\wdi-simple.exe
  Delete $INSTDIR\uninstall.exe
  RMDir "$SMPROGRAMS\proffie-dfu-setup"
  RMDir "$INSTDIR"
SectionEnd
