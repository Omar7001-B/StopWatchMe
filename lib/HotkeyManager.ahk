#NoEnv

RegisterHotkey(hotkeyString, label) {
    if (hotkeyString != "") {
        try {
            Hotkey, %hotkeyString%, %label%, Off
            Hotkey, %hotkeyString%, %label%, On
            return true
        }
    }
    return false
}

RegisterAllHotkeys() {
    global CurrentKeybinds
    Hotkey, IfWinActive
    RegisterHotkey(CurrentKeybinds.StartTask, "StartStopWatchLabel")
    RegisterHotkey(CurrentKeybinds.StopTask, "StopStopWatchLabel")
    RegisterHotkey(CurrentKeybinds.ShowTasks, "ShowTaskRecordsLabel")
    RegisterHotkey(CurrentKeybinds.RestartApp, "RestartTheAppLabel")
    RegisterHotkey(CurrentKeybinds.OpenRecords, "OpenFileOfRecordsLabel")
}

UpdateHotkeys() {
    global CurrentKeybinds
    
    ; Unregister old hotkeys
    Hotkey, IfWinActive
    for key, value in CurrentKeybinds {
        if (value != "") {
            try Hotkey, %value%, Off
        }
    }
    
    ; Register new hotkeys
    RegisterAllHotkeys()
} 