SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\Common Files\Siemens\Automation\Simatic OAM\bin;C:\ProgramData\Oracle\Java\javapath;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;E:\Matlab\bin;C:\Program Files\MySQL\MySQL Utilities 1.6\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Schneider Electric\Machine Expert Installer\;C:\Users\Johan\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\Johan\AppData\Local\GitHubDesktop\bin;C:\Users\Johan\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\Johan\AppData\Local\GitHubDesktop\bin
export AS_BUILD_MODE := Build
export AS_VERSION := 4.5.2.102
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Johan
export AS_PATH := E:/Automation Studio/AS45
export AS_BIN_PATH := E:/Automation Studio/AS45/bin-en
export AS_PROJECT_PATH := C:/Users/Johan/Documents/GitHub/SchoolStuff/Simuleringsopgave_Eksamen/PLC_Eksamens_Projekt
export AS_PROJECT_NAME := PLC_Eksamens_Projekt
export AS_SYSTEM_PATH := E:/Automation\ Studio/AS/System
export AS_VC_PATH := E:/Automation\ Studio/AS45/AS/VC
export AS_TEMP_PATH := C:/Users/Johan/Documents/GitHub/SchoolStuff/Simuleringsopgave_Eksamen/PLC_Eksamens_Projekt/Temp
export AS_CONFIGURATION := Config1
export AS_BINARIES_PATH := C:/Users/Johan/Documents/GitHub/SchoolStuff/Simuleringsopgave_Eksamen/PLC_Eksamens_Projekt/Binaries
export AS_GNU_INST_PATH := E:/Automation\ Studio/AS45/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := $(AS_GNU_INST_PATH)/bin
export AS_GNU_INST_PATH_SUB_MAKE := E:/Automation Studio/AS45/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := $(AS_GNU_INST_PATH_SUB_MAKE)/bin
export AS_INSTALL_PATH := E:/Automation\ Studio/AS45
export WIN32_AS_PATH := "E:\Automation Studio\AS45"
export WIN32_AS_BIN_PATH := "E:\Automation Studio\AS45\bin-en"
export WIN32_AS_PROJECT_PATH := "C:\Users\Johan\Documents\GitHub\SchoolStuff\Simuleringsopgave_Eksamen\PLC_Eksamens_Projekt"
export WIN32_AS_SYSTEM_PATH := "E:\Automation Studio\AS\System"
export WIN32_AS_VC_PATH := "E:\Automation Studio\AS45\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Users\Johan\Documents\GitHub\SchoolStuff\Simuleringsopgave_Eksamen\PLC_Eksamens_Projekt\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Users\Johan\Documents\GitHub\SchoolStuff\Simuleringsopgave_Eksamen\PLC_Eksamens_Projekt\Binaries"
export WIN32_AS_GNU_INST_PATH := "E:\Automation Studio\AS45\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "E:\Automation Studio\AS45"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/PLC_Eksamens_Projekt.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'Build'   

