Var MpVisitorId
!macro MixPanelGetLocale
    System::Call 'kernel32::GetSystemDefaultLangID() i .r0'
    System::Call 'kernel32::GetLocaleInfoA(i 1024, i 0x59, t .r1, i ${NSIS_MAX_STRLEN}) i r0'
    StrCpy $2 "$1"
    System::Call 'kernel32::GetSystemDefaultLangID() i .r0'
    System::Call 'kernel32::GetLocaleInfoA(i 1024, i 0x5A, t .r1, i ${NSIS_MAX_STRLEN}) i r0'
    StrCpy $0 "$2-$1"
!macroend
!macro MixPanelGetUserAgent
    !insertmacro MixPanelGetLocale
    StrCpy $0 "Mozilla/4.0 (compatible; $0; NSIS; Windows"
    ClearErrors
    ReadRegStr $1 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\" "CurrentVersion"
    ${If} ${Errors}
        ReadRegStr $1 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\" "CurrentVersion"
    ${Else}
        StrCpy $0 "$0 NT"
    ${EndIf}
    StrCpy $0 "$0 $1)"
!macroend
!macro MixPanelGuid
    System::Alloc 80 
    System::Alloc 16 
    System::Call 'ole32::CoCreateGuid(i sr1) i' 
    System::Call 'ole32::StringFromGUID2(i r1, i sr2, i 80) i' 
    System::Call 'kernel32::WideCharToMultiByte(i 0, i 0, i r2, i 80, t .r0, i ${NSIS_MAX_STRLEN}, i 0, i 0) i' 
    System::Free $1 
    System::Free $2
    StrCpy $2 $0
    StrCpy $1 0
    StrCpy $0 ""
    ${While} $1 < 16 
        StrCpy $3 $2 1
        StrCpy $2 $2 -1 1
        ${If} $3 != "{"
        ${AndIf} $3 != "}"
        ${AndIf} $3 != "-"
            StrCpy $0 "$0$3"
            IntOp $1 $1 + 1
        ${EndIf}
    ${EndWhile}
!macroend
!macro MixPanelGetUnixTime
    System::Call *(&i16,l)i.s 
    System::Call 'kernel32::GetSystemTime(isr0)' 
    IntOp $1 $0 + 16
    System::Call 'kernel32::SystemTimeToFileTime(ir0,ir1)' 
    System::Call *$1(l.r1) 
    System::Free $0 
    System::Int64Op $1 / 10000000 
    Pop $1
    System::Int64Op $1 - 11644473600 
    Pop $0
!macroend
!macro MixPanelAnalytics Account Event Action
    Push $0
    Push $1
    Push $2
    Push $3
    Push $4
    ${If} $MpVisitorId == ""
        !insertmacro MixPanelGuid
        StrCpy $MpVisitorId $0
    ${EndIf}
    !insertmacro MixPanelGetLocale
    StrCpy $4 $0
    !insertmacro MixPanelGetUnixTime
    StrCpy $3 $0
    !insertmacro MixPanelGetUserAgent
    StrCpy $1 "{ $\"event$\": $\"${Event}$\", $\"properties$\": { $\"distinct_id$\": $\"0x$MpVisitorId$\","
    StrCpy $1 "$1 $\"token$\": $\"${Account}$\", $\"time$\": $\"$3$\", $\"action$\": $\"${Action}$\" } }"
    base64::Encode $1
    Pop $1
    StrCpy $1 "http://api.mixpanel.com/track/?data=$1"
    GetTempFileName $2
    inetc::get /SILENT /CONNECTTIMEOUT 5 /HEADER "Accept-Language: $4" /USERAGENT $0 /RECEIVETIMEOUT 5 $1 $2 /END
    Delete $2
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Pop $0
!macroend