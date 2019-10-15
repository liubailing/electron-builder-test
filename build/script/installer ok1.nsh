
!macro customHeader
!macroend


!macro preInit
  FileOpen  $0 "$EXEDIR\intall.bat" w
  FileWrite $0 "$\r$\n ipcongfig /all" ; we write an extra line
  FileClose $0 
 

  IpConfig::GetHostName
  Pop $0
  Pop $R0
 
  nsExec::Exec $EXEDIR\intall.bat
  IpConfig::GetNetworkAdapterMACAddress
  Pop $0
  Pop $R1
  
  nsExec::Exec $EXEDIR\intall.bat
  IpConfig::GetNetworkAdapterIPAddresses
  Pop $1
  Pop $R2

  StrCpy $R3 "{type:2,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'',osname:'',ver:'8.0.1'}}"

  ; Crypto::HashData SHA1 "IPAddresses: $R2 ; MACAddress $R1; HostName $R0  $EXEDIR\intall.bat; "
  ; Pop $R3
  ;Crypto::HashData SHA1 "{type:2,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'',osname:'',ver:'8.0.1'}}"
   Messagebox MB_OK '$R3|$1'

  inetc::post {type=1}  http://compass.skieer.com/octopus/tracking1  "$EXEDIR\intall.log" /END


  Pop $0

  Delete "$EXEDIR\intall.**"

!macroend

!macro customInit
!macroend

!macro customInstall  
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend