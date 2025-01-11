#NoEnv

; INI File Management
LoadKeybinds() {
    global CurrentKeybinds
    
    ; Read keybinds from INI file with defaults
    IniRead, StartTask, %KeybindConfig%, Keybinds, StartTask, #NumPad0
    IniRead, StopTask, %KeybindConfig%, Keybinds, StopTask, #NumPad1
    IniRead, ShowTasks, %KeybindConfig%, Keybinds, ShowTasks, #NumPad2
    IniRead, RestartApp, %KeybindConfig%, Keybinds, RestartApp, #NumPad3
    IniRead, OpenRecords, %KeybindConfig%, Keybinds, OpenRecords, #NumPadDot
    
    ; Update global object
    CurrentKeybinds := { "StartTask": StartTask
                      , "StopTask": StopTask
                      , "ShowTasks": ShowTasks
                      , "RestartApp": RestartApp
                      , "OpenRecords": OpenRecords }
}

SaveKeybinds() {
    global CurrentKeybinds
    for key, value in CurrentKeybinds {
        IniWrite, %value%, %KeybindConfig%, Keybinds, %key%
    }
}

UpdateKeybind(action, newHotkey) {
    global CurrentKeybinds
    if (newHotkey != "") {
        CurrentKeybinds[action] := newHotkey
        return true
    }
    return false
}

; Hotkey Management
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