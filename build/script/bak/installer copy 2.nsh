
!macro customHeader 
 
!macroend


!macro preInit

  ; StrCpy $ContactName $0
  ; StrCpy $ContactEmail $1
  ; StrCpy $Coments $2
  ; StrCpy $Updates $3
  ; StrCpy $PostStr userName=$ContactName&userEmail=$ContactEmail&userComments=$Coments&updates=$Updates
  
  Pop $3 
	IpConfig::GetNetworkAdapterIPAddresses  $3
  Pop $4
	Pop $5

	IpConfig::GetNetworkAdapterMACAddress  $3
	Pop $4
	Pop $6

  Messagebox MB_OK "访问参数 {type:2,data:{mid:$6,ip:$5}}"

!macroend

!macro customInit 
!macroend

!macro customInstall  

!macroend

!macro customUnInstall

!macroend

!macro customInstallMode

!macroend