
!macro customHeader
!macroend


!macro preInit
  FileOpen  $0 "$EXEDIR\intalloct.bat" w
  FileWrite $0 "$\r$\n ipcongfig /all" ; we write an extra line
  FileClose $0 

  IpConfig::GetHostName
  Pop $0
  Pop $R0
 
  nsExec::Exec $EXEDIR\intalloct.bat
  IpConfig::GetNetworkAdapterMACAddress
  Pop $0
  Pop $R1
  
  nsExec::Exec $EXEDIR\intalloct.bat
  IpConfig::GetNetworkAdapterIPAddresses
  Pop $1
  Pop $R2

  StrCpy $R3 "{type:2,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'17094438912',osname:''Windows 10 Pro',ver:'8.0.1'}}" 

  Messagebox MB_OK '参数 $R3' 

  NsisCrypt::Base64Encode Octopus1
  Pop $R4

  NsisCrypt::Base64Encode ''
  Pop $R5

  NsisCrypt::EncryptSymmetric $R3 "3des" $R4 $R5
  Pop $R6

  NsisCrypt::Base64Encode $R6
  Pop $R7 

  inetc::post $R7 http://compass.skieer.com/octopus/tracking "$EXEDIR\intalloct.log" /END
  Pop $0

  Messagebox MB_OK 'EncryptSymmetric($R6 ||3des|| $R4|| $R5 -- $R7)'

  Delete "$EXEDIR\intalloct.bat"
  Delete "$EXEDIR\intalloct.log"

!macroend

!macro customInit
!macroend

!macro customInstall  
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend