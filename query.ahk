^+e:: WebSite_Clipboard("https://www.google.com.tw/search?q=","","Google搜尋","True")

^+u:: WebSite_Clipboard("https://www.youtube.com/results?search_query=","","Youtube搜尋","True")

^+c:: WebSite_Clipboard("https://www.moedict.tw/","","萌典(中文字典)","True")

^+g:: WebSite_Clipboard("https://www.google.com.tw/search?q=","","Google搜尋","True")

^+w:: WebSite_Clipboard("http://zh.wikipedia.org/w/index.php?title=Special:Search&search=","","WIKI維基百科","True")

^+m:: WebSite_Clipboard("https://www.google.com.tw/maps/search/","","Google地圖搜尋","True")


;將關鍵字帶入網址查詢(version:190624)
WebSite_Clipboard(UrlA,UrlB,website_name:="",ShowInputBox:="True"){
    ;備份並清空剪貼簿
    clipboard_save = %ClipboardAll%
    Clipboard :=""
    ;獲取選取的關鍵字
    Send ^{c}
    Sleep 200
    keyWord = %Clipboard%
    ;恢復先前的剪貼簿
    Clipboard = %clipboard_save%
    ;若沒有選取文字被選取，則跳出輸入文字框讓使用者輸入關鍵字，複製到剪貼簿
    if (keyWord="" and ShowInputBox="True"){
        ;若未設定網站名稱，則用
        if (website_name=""){
            website_name=%UrlA%
        }
        InputBox, keyWord,搜尋關鍵字,%website_name%,,,150
    }
    ;將關鍵字做解碼處理，並嵌入搜尋網址中
    if (ErrorLevel=0 and keyWord!=""){
        Copy= % UriEncode(keyWord)
        Run %UrlA%%Copy%%UrlB%
    }
    return
}



;讓關鍵字轉化為網址解碼形式，得以讓關鍵字正確被搜尋
;參考自https://rosettacode.org/wiki/URL_encoding#AutoHotkey
UriEncode(Uri){
    VarSetCapacity(Var, StrPut(Uri, "UTF-8"), 0)
    StrPut(Uri, &Var, "UTF-8")
    f := A_FormatInteger
    SetFormat, IntegerFast, H
    While Code := NumGet(Var, A_Index - 1, "UChar")
        If (Code >= 0x30 && Code <= 0x39 ; 0-9
            || Code >= 0x41 && Code <= 0x5A ; A-Z
            || Code >= 0x61 && Code <= 0x7A) ; a-z
            Res .= Chr(Code)
        Else
            Res .= "%" . SubStr(Code + 0x100, -1)
    SetFormat, IntegerFast, %f%
    Return, Res
}

