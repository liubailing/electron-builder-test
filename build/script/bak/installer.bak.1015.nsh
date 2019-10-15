
!macro customHeader 
 
!macroend


!macro preInit
  
  ; nsExec::Exec installer.bat

  ;Pop $R1
  ;IpConfig::GetNetworkAdapterIPAddresses
  ;IpConfig::GetNetworkAdapterIDFromMACAddress
  ;Messagebox MB_OK "MACAddress is  $R1"

  ; Pop $3 
	; IpConfig::GetNetworkAdapterMACAddress  $3
  ; Pop $4
	; Pop $5

	;IpConfig::GetNetworkAdapterConnectionID $3
	;Pop $4
	;Pop $6

  ;Pop $3 
	;IpConfig::GetNetworkAdapterMACAddress  $3
	;Pop $4
	;Pop $5

  ; Messagebox MB_OK "访问参数 {type:2,data:{mid:$5,,ver:'7.6.4.4281'}}"
  ; NsisCrypt::Base64Encode "{type:2,data:{cname:'$5'}}"
  ; Pop $6
  
  ; ShellExecAsUser::ShellExecAsUser open http://compass.skieer.com/octopus/tracking?p=$6

  ; inetc::post 11111 http://compass.skieer.com/octopus/tracking?p=$6 
  Pop $0

!macroend

!macro customInit 
!macroend

!macro customInstall  
  ; 流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  ; NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=install install.zip
  ; nsExec::Exec installer.bat
!macroend

!macro customUnInstall
  ; 流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  ; NSISdl::download https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=uninstall uninstall.zip
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend