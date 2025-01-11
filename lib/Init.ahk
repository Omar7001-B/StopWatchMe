#NoEnv
#SingleInstance Force
#InstallKeybdHook
SetWorkingDir, %A_ScriptDir%

; Global variables for the main script
global TaskNames := []
global TaskDurations := []
global FilePath := A_ScriptDir . "\data\StopWatchRecords.txt"
global TaskName := ""
global StartTime := 0
global Duration := "00:00:00"
global TaskStartTime := ""
global TaskStopTime := ""
global DebugIncrement := 0

; Global variables for keybind storage
global KeybindConfig := A_ScriptDir . "\config\keybinds.ini"
global CurrentKeybinds := {}

; Global variables for GUI controls
global StartTaskHK
global StopTaskHK
global ShowTasksHK
global RestartAppHK
global OpenRecordsHK 