; This examples demonstrates how libwdi can be used in an installer script
; to automatically install USB drivers along with your application.
;
; Requirements: Inno Setup (http://www.jrsoftware.org/isdl.php)
;
; To use this script, do the following:
; - configure libwdi (see config.h)
; - compile wdi-simple.exe
; - customize this script (application strings, wdi-simple.exe parameters, etc.)
; - open this script with Inno Setup
; - compile and run

[Setup]
AppName = Proffie STM32 BOOTLOADER Driver
AppVerName = V1.0
AppPublisher = Proffezzorn
AppPublisherURL = https://fredrik.hubbe.net/
AppVersion = 1.0
DefaultDirName = {commonpf}\DriverInstaller
DefaultGroupName = Proffie STM32 BOOTLOADER Driver
Compression = lzma
SolidCompression = yes

; This installation requires admin privileges. This is needed to install
; drivers on windows vista and later.
PrivilegesRequired = admin
DisableProgramGroupPage=yes

[Files]
; copy the 32bit wdi installer to the application directory.
; note: this installer also works with 64bit
Source: "wdi-simple.exe"; DestDir: "{app}"; Flags: replacesameversion promptifolder;

[Icons]
Name: "{group}\Uninstall YourApplication"; Filename: "{uninstallexe}"

[Run]
; call wdi-simple
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
;
Filename: "{app}\wdi-simple.exe"; Flags: "runhidden"; Parameters: " --name ""STM32  BOOTLOADER"" --vid 0x0483 --pid 0xdf11 --progressbar={wizardhwnd} --timeout 120000 -t0"; StatusMsg: "Installing STM32 BOOTLOADER driver (this may take a few seconds) ...";

