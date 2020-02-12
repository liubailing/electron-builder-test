!include nsDialogs.nsh
!include LogicLib.nsh

#OutFile nsDialogs.exe
#RequestExecutionLevel user
#ShowInstDetails show

Var Dialog
Var /GLOBAL store_code_t
Var /GLOBAL pos_name_t
Var /GLOBAL store_code
Var /GLOBAL pos_name

Page custom pgPageCreate pgPageLeave

Function pgPageCreate

    nsDialogs::Create 1018
    Pop $Dialog

    ${If} $Dialog == error
        Abort
    ${EndIf}

    ${NSD_CreateGroupBox} 10% 10u 80% 100u "设置"
    Pop $0

        ${NSD_CreateLabel} 20% 26u 20% 10u "store_code:"
        Pop $0

        ${NSD_CreateText} 40% 24u 40% 12u "000"
        Pop $store_code_t

        ${NSD_CreateLabel} 20% 40u 20% 10u "pos_name:"
        Pop $0

        ${NSD_CreateText} 40% 38u 40% 12u "001"
        Pop $pos_name_t

    nsDialogs::Show
FunctionEnd

Function PgPageLeave
    ${NSD_GetText} $store_code_t $store_code
    ${NSD_GetText} $pos_name_t $pos_name 
FunctionEnd

Section

SectionEnd
;一下都是官方提供的回调方法
;可以使用NSIS的 MessageBox  进行调试熟悉这些回调，打包有点繁琐
;MessageBox MB_YESNO "真的吗？" IDYES true IDNO false
;true:
 ; DetailPrint "是真的！"
  ;Goto next
;false:
 ; DetailPrint "是假的"

!macro customInstall
  ; WriteINIStr $INSTDIR\web.ini base store_code $store_code
  ; WriteINIStr $INSTDIR\web.ini base pos_name $pos_name
  ; ReadINIStr $INSTDIR\web.ini  "ver" $R1
  ; Pop $R8
!macroend
!macro customHeader
  !system "echo '' > ${BUILD_RESOURCES_DIR}/customHeader"
!macroend

!macro preInit
  ; This macro is inserted at the beginning of the NSIS .OnInit callback
  !system "echo '' > ${BUILD_RESOURCES_DIR}/preInit"
!macroend

!macro customInit
  !system "echo '' > ${BUILD_RESOURCES_DIR}/customInit"
!macroend

!macro customInstallMode
  # set $isForceMachineInstall or $isForceCurrentInstall 
  # to enforce one or the other modes.
!macroend
