!macro customHeader
!macroend

!macro preInit
!macroend

!macro customInit
!macroend

!macro customInstall 
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

  StrCpy $R3 "{type:1,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'17094438912',osname:'Windows',ver:'8.0.4'}}" 
  
  InitPluginsDir ;make sure we have $pluginsdir
  File "/ONAME=$pluginsdir\NsisCrypt.dll" "${NSISDIR}\Plugins\x86-ansi\NsisCrypt.dll" ;you must extract the ansi plugin manually
  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'yourkey'
  Pop $R4

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'yourkey'
  Pop $R5

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" EncryptSymmetric 4  $R3 "des" $R4 $R5
  Pop $R6

  inetc::post $R6 /HEADER "Content-Type:text/html" http://youwebsitehost/api/account/install "$EXEDIR\unintalloct.log" /END
  Pop $0

  # 测试代码 需要注释 begin
  ; StrCpy $R7 '**PARAMS**: $\t $R3 $\r$\r$\n **ENCODE**: $\t des-cbc|| $R4|| $R5 $\r$\r$\n **DES-CBC RESULT**:  $\t  $R6 $\r$\r$\n'
  ; Messagebox MB_OK $R7
  ; FileOpen  $0 "$EXEDIR\encode.log" w
  ; FileWrite $0  $R7 ; we write an extra line
  ; FileClose $0 
  # 测试代码 需要注释 end

  ; Delete "$EXEDIR\intalloct.bat"
  ; Delete "$EXEDIR\intalloct.log" 
!macroend

!macro customUnInstall

 FileOpen  $0 "$EXEDIR\unintalloct.bat" w
  FileWrite $0 "$\r$\n ipcongfig /all" ; we write an extra line
  FileClose $0 

  IpConfig::GetHostName
  Pop $0
  Pop $R0
 
  nsExec::Exec $EXEDIR\unintalloct.bat
  IpConfig::GetNetworkAdapterMACAddress
  Pop $0
  Pop $R1
  
  nsExec::Exec $EXEDIR\unintalloct.bat
  IpConfig::GetNetworkAdapterIPAddresses
  Pop $1
  Pop $R2

  StrCpy $R3 "{type:2,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'17094438912',osname:'Windows',ver:'8.0.4'}}" 
  
  InitPluginsDir ;make sure we have $pluginsdir
  File "/ONAME=$pluginsdir\NsisCrypt.dll" "${NSISDIR}\Plugins\x86-ansi\NsisCrypt.dll" ;you must extract the ansi plugin manually
  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'yourkey'
  Pop $R4

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'yourkey'
  Pop $R5

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" EncryptSymmetric 4  $R3 "des" $R4 $R5
  Pop $R6

  inetc::post $R6 /HEADER "Content-Type:text/html" http://youwebsitehost/api/account/install "$EXEDIR\unintalloct.log" /END
  Pop $0

  ;Messagebox MB_OK '**PARAMS**: $\t $R3 $\r$\r$\n **ENCODE**: $\t 3des|| $R4|| $R5 $\r$\r$\n *3DES RESULT* $R6'

  ; Delete "$EXEDIR\unintalloct.bat"
  ; Delete "$EXEDIR\unintalloct.log" 

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 $R1
  Pop $R7

  ShellExecAsUser::ShellExecAsUser open 'https://yourwebsitehost/uninstallquestionaire?data=$R7=&version=v8.0.4'

!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend