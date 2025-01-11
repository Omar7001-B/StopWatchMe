#NoEnv

ShowKeybindGui() {
    global CurrentKeybinds
    ; Declare GUI variables as global
    global StartTaskHK, StopTaskHK, ShowTasksHK, RestartAppHK, OpenRecordsHK
    global StartTaskWin, StopTaskWin, ShowTasksWin, RestartAppWin, OpenRecordsWin
    
    ; Create GUI
    Gui, Keybind:New, +AlwaysOnTop, Keybind Configuration
    Gui, Keybind:Add, Text, x10 y10, Configure Hotkeys
    
    ; Set current values and check for Windows key
    StartTaskHK := RegExReplace(CurrentKeybinds.StartTask, "^#", "")
    StopTaskHK := RegExReplace(CurrentKeybinds.StopTask, "^#", "")
    ShowTasksHK := RegExReplace(CurrentKeybinds.ShowTasks, "^#", "")
    RestartAppHK := RegExReplace(CurrentKeybinds.RestartApp, "^#", "")
    OpenRecordsHK := RegExReplace(CurrentKeybinds.OpenRecords, "^#", "")
    
    ; Check if Windows key is present
    StartTaskWin := InStr(CurrentKeybinds.StartTask, "#") = 1 ? 1 : 0
    StopTaskWin := InStr(CurrentKeybinds.StopTask, "#") = 1 ? 1 : 0
    ShowTasksWin := InStr(CurrentKeybinds.ShowTasks, "#") = 1 ? 1 : 0
    RestartAppWin := InStr(CurrentKeybinds.RestartApp, "#") = 1 ? 1 : 0
    OpenRecordsWin := InStr(CurrentKeybinds.OpenRecords, "#") = 1 ? 1 : 0
    
    ; Add controls with WIN checkboxes
    Gui, Keybind:Add, Text, x10 y40, Start Task:
    Gui, Keybind:Add, Hotkey, x120 y37 w150 vStartTaskHK, %StartTaskHK%
    Gui, Keybind:Add, Checkbox, x280 y40 vStartTaskWin Checked%StartTaskWin%, WIN
    
    Gui, Keybind:Add, Text, x10 y70, Stop Task:
    Gui, Keybind:Add, Hotkey, x120 y67 w150 vStopTaskHK, %StopTaskHK%
    Gui, Keybind:Add, Checkbox, x280 y70 vStopTaskWin Checked%StopTaskWin%, WIN
    
    Gui, Keybind:Add, Text, x10 y100, Show Tasks:
    Gui, Keybind:Add, Hotkey, x120 y97 w150 vShowTasksHK, %ShowTasksHK%
    Gui, Keybind:Add, Checkbox, x280 y100 vShowTasksWin Checked%ShowTasksWin%, WIN
    
    Gui, Keybind:Add, Text, x10 y130, Restart App:
    Gui, Keybind:Add, Hotkey, x120 y127 w150 vRestartAppHK, %RestartAppHK%
    Gui, Keybind:Add, Checkbox, x280 y130 vRestartAppWin Checked%RestartAppWin%, WIN
    
    Gui, Keybind:Add, Text, x10 y160, Open Records:
    Gui, Keybind:Add, Hotkey, x120 y157 w150 vOpenRecordsHK, %OpenRecordsHK%
    Gui, Keybind:Add, Checkbox, x280 y160 vOpenRecordsWin Checked%OpenRecordsWin%, WIN
    
    ; Add buttons
    Gui, Keybind:Add, Button, x80 y200 w100 gSaveKeybindChanges, Save
    Gui, Keybind:Add, Button, x190 y200 w100 gCancelKeybindChanges, Cancel
    
    ; Add help text
    helpText := "Instructions:`n1. Click on any field`n2. Press your desired key combination`n3. Check WIN if you want to use the Windows key`n4. Click Save when done"
    Gui, Keybind:Add, Text, x10 y240 w300, %helpText%
    
    Gui, Keybind:Show
}

; GUI Labels
SaveKeybindChanges:
{
    Gui, Submit, NoHide

    ; Update non-empty keybinds using KeybindManager's UpdateKeybind function
    if (StartTaskHK != "") {
        finalHK := (StartTaskWin ? "#" : "") . StartTaskHK
        UpdateKeybind("StartTask", finalHK)
    }
    if (StopTaskHK != "") {
        finalHK := (StopTaskWin ? "#" : "") . StopTaskHK
        UpdateKeybind("StopTask", finalHK)
    }
    if (ShowTasksHK != "") {
        finalHK := (ShowTasksWin ? "#" : "") . ShowTasksHK
        UpdateKeybind("ShowTasks", finalHK)
    }
    if (RestartAppHK != "") {
        finalHK := (RestartAppWin ? "#" : "") . RestartAppHK
        UpdateKeybind("RestartApp", finalHK)
    }
    if (OpenRecordsHK != "") {
        finalHK := (OpenRecordsWin ? "#" : "") . OpenRecordsHK
        UpdateKeybind("OpenRecords", finalHK)
    }

    ; Save changes
    SaveKeybinds()
    
    ; Update hotkeys using HotkeyManager
    UpdateHotkeys()
    
    ; Close GUI quietly
    Gui, Keybind:Destroy
}
return

CancelKeybindChanges:
Gui, Keybind:Destroy
return

KeybindGuiClose:
Gui, Keybind:Destroy
return 