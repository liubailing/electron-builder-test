
!macro customHeader  
!macroend


!macro preInit   
!macroend

!macro customInit 
!macroend

!macro customInstall  
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download 'https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=install' 'install.zip'
!macroend

!macro customUnInstall
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download 'https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=uninstall' 'uninstall.zip'
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend