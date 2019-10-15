
!macro customHeader 
 
!macroend


!macro preInit
  inetc::post {type=1} http://compass.skieer.com/octopus/tracking f:\output.log /END
  Pop $0

!macroend

!macro customInit 
!macroend

!macro customInstall  

!macroend

!macro customUnInstall

!macroend

!macro customInstallMode

!macroend