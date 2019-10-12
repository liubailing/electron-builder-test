; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines custom install default dir




!macro customHeader  
  !system "echo 'customHeader' > G:/customHeader.txt"
!macroend


!macro preInit

    ; NSISdl::download_quiet 'http://download.nullsoft.com/winamp/client/winamp291_lite.exe' 

    ;NSISdl::download 'http://download.nullsoft.com/winamp/client/winamp291_lite.exe' 'localfile.exe'

     
    ; Pop $R0 ;Get the return value
    ;   StrCmp $R0 "success" +3
    ;     MessageBox MB_OK "Download failed: $R0"
    ;     Quit


   Push $R0
    
    ClearErrors
    Dialer::AttemptConnect
    IfErrors noie3
    
    Pop $R0
    StrCmp $R0 "online" connected
      MessageBox MB_OK|MB_ICONSTOP "Cannot connect to the internet."
      Quit ;Remove to make error not fatal
    
    noie3:
  
    ; IE3 not installed
    MessageBox MB_OK|MB_ICONINFORMATION "Please connect to the internet now."
    
    connected:
      Pop $R0


    UserInfo::GetName
    Pop $R2
    !system "echo 'preInit {$R2}' > G:/preInit.txt"

    Messagebox MB_OK "preInit {$R2}"
    SetRegView 64

    
    WriteRegExpandStr HKLM "${INSTALL_REGISTRY_KEY}" InstallLocation "G:\test"
    WriteRegExpandStr HKCU "${INSTALL_REGISTRY_KEY}" InstallLocation "G:\test"
    SetRegView 32
    WriteRegExpandStr HKLM "${INSTALL_REGISTRY_KEY}" InstallLocation "G:\test"
    WriteRegExpandStr HKCU "${INSTALL_REGISTRY_KEY}" InstallLocation "G:\test"
!macroend

!macro customInit
  !system "echo '' > G:/customInit.txt"
!macroend

!macro customInstall
  !system "echo 'customInstall' > G:/customInstall.txt"
  System::Call 'shell32.dll::SHChangeNotify(l, l, i, i) v (0x08000000, 0, 0, 0)'
  System::Call 'shell32.dll::Start-Process -FilePath  www.powershellmagazine.com'
  #System::Call 'PowerShellExec "Start-Process -FilePath  www.powershellmagazine.com"'
  Messagebox MB_OK "customInstall"
  System::Call 'shell32.dll:ShellExecute(NULL,"open","www.baidu.com",NULL,NULL,SW_SHOWNORMAL)';
  
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download 'https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=install' 'install.zip'

  ShellExecAsUser::ShellExecAsUser "open" "http://www.qq.com/"
  ShellExecAsUser::ShellExecAsUser "open" 'http://www.google.com/'
  System::Call 'ShellExecAsUser.dll::ShellExecAsUser "open" "http://www.qq.com/"'
 

!macroend

!macro customUnInstall

  Messagebox MB_OK "customUnInstall"
  ;流氓要求  要求下载一个文件，其实就是要一个请求然后记录信息
  NSISdl::download 'https://nsis.sourceforge.io/mediawiki/images/c/c7/ShellExecAsUser.zip?x=uninstall' 'uninstall.zip'
  !system "echo 'customUnInstall' > G:/customUnInstall.txt"

!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend