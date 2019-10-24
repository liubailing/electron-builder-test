
!macro customHeader
!macroend


!macro preInit

  GetVersion::WindowsName
  Pop $R0
  MessageBox MB_OK "WindowsName: $R0"

 GetVersion::WindowsType
  Pop $0
  MessageBox MB_OK "WindowsType: $0"

 GetVersion::WindowsVersion
  Pop $0
  MessageBox MB_OK "WindowsVersion: $0"

 GetVersion::WindowsServerName
  Pop $0
  MessageBox MB_OK "WindowsServerName: $0"

 GetVersion::WindowsPlatformId
  Pop $0
  MessageBox MB_OK "WindowsPlatformId:  $0"

 GetVersion::WindowsPlatformArchitecture
  Pop $0
  MessageBox MB_OK "WindowsPlatformArchitecture:  $0"

 GetVersion::WindowsServicePack
  Pop $R1
  MessageBox MB_OK "WindowsServicePack:  $R1"

 GetVersion::WindowsServicePackBuild
  Pop $R2
  MessageBox MB_OK "WindowsServicePackBuild: $R2"

 GetVersion::WindowsServicePackMinor
  Pop $R3
  MessageBox MB_OK "WindowsServicePackMinor: $R3"

 GetVersion::WindowsServicePackMajor
  Pop $R4
  MessageBox MB_OK "WindowsServicePackMajor:  $R4"


!macroend

!macro customInit
!macroend

!macro customInstall 
!macroend

!macro customUnInstall
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend