#Requires AutoHotkey v1.1

; First, include initialization file which sets up all globals and settings
#Include <Init>
#Include <TimerFunctions>
#Include <KeybindManager>

; Auto-execute section starts here
OnExit("ExitCallback", 1)

; Load keybinds and register hotkeys
LoadKeybinds()
RegisterAllHotkeys()

#Include <KeybindGUI>

; Initialize the application
WelcomeFunction()
return ; End of auto-execute section

; Hotkey to open keybind configuration
^+k::ShowKeybindGui()

; Labels for hotkey actions
StartStopWatchLabel:
StartStopWatch()
return

StopStopWatchLabel:
StopStopWatch()
return

ShowTaskRecordsLabel:
ShowTaskRecords()
return

RestartTheAppLabel:
RestartTheApp()
return

OpenFileOfRecordsLabel:
OpenFileOfRecords()
return
