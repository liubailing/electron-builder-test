
!macro customHeader
!macroend


!macro preInit

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

  StrCpy $R3 "{type:2,data:{cname:'$R0',mid:'$R1',ip:'$R2',os:'',cpu:'4',mem:'17094438912',osname:''Windows 10 Pro',ver:'8.0.1'}}" 
  
  ;StrCpy $R3 'test123'

  InitPluginsDir ;make sure we have $pluginsdir
  File "/ONAME=$pluginsdir\NsisCrypt.dll" "${NSISDIR}\Plugins\x86-ansi\NsisCrypt.dll" ;you must extract the ansi plugin manually

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'Octopus1'
  Pop $R4

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 'Octopus1'
  Pop $R5

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" EncryptSymmetric 4  $R3 "des" $R4 $R5
  Pop $R6

  CallAnsiPlugin::Call "$pluginsdir\NsisCrypt" Base64Encode 1 $R6
  Pop $R7  

  # 测试代码 需要注释 begin
  StrCpy $R8 '**PARAMS**: $\t $R3 $\r$\r$\n **ENCODE**: $\t des-cbc|| $R4|| $R5 $\r$\r$\n **DES-CBC RESULT**:  $\t  $R6 $\r$\r$\n **Base64 RESULT**: $\t $R7'
  Messagebox MB_OK $R8
  FileOpen  $0 "$EXEDIR\encode.log" w
  FileWrite $0  $R8 ; we write an extra line
  FileClose $0 
  # 测试代码 需要注释 end

  ; Delete "$EXEDIR\unintalloct.bat"
  ; Delete "$EXEDIR\unintalloct.log" 

  ShellExecAsUser::ShellExecAsUser open https://www.bazhuayu.com/uninstallquestionaire?data=NDg6NEQ6N0U6QTg6RDA6RUM=&version=v8.0.1

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