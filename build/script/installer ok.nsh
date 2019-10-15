
!macro customHeader
!macroend


!macro preInit
 

!macroend

!macro customInit



  ;ShellExecAsUser::ShellExecAsUser open http://www.google.com/
  
!macroend

!macro customInstall
  FileOpen  $0 "$EXEDIR\intall.bat" w
  FileWrite $0 "$\r$\n ipcongfig /all" ; we write an extra line
  FileClose $0
  
; !system "echo 'echo 1' > $EXEDIR\installer1.bat"
	Messagebox MB_OK "$EXEDIR\intall.bat; "
  Delete "$EXEDIR\intall.bat"

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

  Crypto::HashData SHA1 "IPAddresses: $R2 ; MACAddress $R1; HostName $R0  $EXEDIR\intall.bat; "
  Pop $1
  Pop $R3
  Messagebox MB_OK '$R3'
	;Messagebox MB_OK "IPAddresses: $R2 ; MACAddress $R1; HostName $R0  $EXEDIR\intall.bat; "

  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  ;NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=install install.zip
!macroend

!macro customUnInstall
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  ;NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=uninstall uninstall.zip
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend