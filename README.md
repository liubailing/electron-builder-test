# electron-webpack-quick-start
> [`electron-webpack`] + [`electron-builer`]
拿来主义  直接做客户端打包demo 

## 主要工作是做了 electron 打包安装卸载

通过配置修改打包配置package.json引入installer.nsh文件。
electron-builder 可以读取这个文件，然后再对应得钩子接口执行对应的步骤操作，比如安装时、卸载时 做出对应的操作。

* electron-builder nsis 本身带的dll 不多，如果需要引用第三方dll。本项目依赖已经放置在 @\lib
* 需要放在对应的文件夹下面：eg C:\Users\bzy_lbl\AppData\Local\electron-builder\Cache\nsis\nsis-3.0.3.2\Plugins,然后对应的编码的dll放入对应的dll文件夹(x86-ansi,x86-unicode)
* 这里有的dll只提供得ascii得编码。可以通过 CallAnsiPlugin.dll 调用。这个时候要注意参数问题

``` javascript 

 //安装时 钩子操作
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

  inetc::post $R6 /HEADER "Content-Type:text/html" http://yourwebhost/api/account/install "$EXEDIR\intalloct.log" /END
  Pop $0

  # 测试代码 需要注释 begin
  ; StrCpy $R7 '**PARAMS**: $\t $R3 $\r$\r$\n **ENCODE**: $\t des-cbc|| $R4|| $R5 $\r$\r$\n **DES-CBC RESULT**:  $\t  $R6 $\r$\r$\n'
  ; Messagebox MB_OK $R7
  ; FileOpen  $0 "$EXEDIR\encode.log" w
  ; FileWrite $0  $R7 ; we write an extra line
  ; FileClose $0 
  # 测试代码 需要注释 end

  Delete "$EXEDIR\intalloct.bat"
  Delete "$EXEDIR\intalloct.log" 
!macroend
```


### 打包测试
> npm run build

打包得到 可安装文件。
执行安装、卸载,结合fiddler


### 后续

1、有些参数还没得到，需要继续找nsis， dll功能以及接口。
2、中途试着自己写dll实现，虽然生成的dll在c项目中能调用，但是应用过来没生效（编译直接报错），这个问题没有进一步去解决。


