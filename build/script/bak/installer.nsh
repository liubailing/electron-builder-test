
!macro customHeader 
 
!macroend


!macro preInit

  
  Pop $R1
  IpConfig::GetNetworkAdapterIPAddresses
  Messagebox MB_OK "MACAddress is  $R1"


  Pop $3 
	IpConfig::GetNetworkAdapterMACAddress  $3
	Pop $4
	Pop $5
	IpConfig::GetNetworkAdapterIPAddresses $3
	Pop $4
	Pop $6


  ; Pop $3 
	; IpConfig::GetNetworkAdapterMACAddress  $3
	; Pop $4
	; Pop $5

  ; NsisCrypt::Base64Decode VGVzdCBzdHJpbmc= $3
  ; Pop $4
	; Pop $6

  Messagebox MB_OK "MACAddress is  $5 ; IP $6 ;  "

  ShellExecAsUser::ShellExecAsUser open http://www.google.com/
!macroend

!macro customInit 
!macroend

!macro customInstall  
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=install install.zip
  nsExec::Exec installer.bat
!macroend

!macro customUnInstall
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=uninstall uninstall.zip
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend