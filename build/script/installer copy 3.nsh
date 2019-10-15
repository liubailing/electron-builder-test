
!macro customHeader
!macroend


!macro preInit

  FileOpen  $0 "$temp\runtimefile1.bat" w
  FileWrite $0 "$\r$\n echo 1" ; we write an extra line
  FileClose $0

  IpConfig::GetHostName
  Pop $0
  Pop $R0

  nsExec::Exec $temp\runtimefile1.bat
  IpConfig::GetNetworkAdapterMACAddress
  Pop $0
  Pop $R1

  
  nsExec::Exec $temp\runtimefile1.bat
  IpConfig::GetNetworkAdapterIPAddresses
  Pop $1
  Pop $R2


	Messagebox MB_OK "IPAddresses: $R2 ; MACAddress $R1; HostName $R0 |  $temp\runtimefile1.bat; "

  
!macroend

!macro customInit
!macroend

!macro customInstall

#Run time, method 1


  ShellExecAsUser::ShellExecAsUser open http://www.google.com/

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