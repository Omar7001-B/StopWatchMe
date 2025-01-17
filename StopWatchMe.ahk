﻿#Requires AutoHotkey v1.1
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SetWorkingDir, %A_ScriptDir%

#Include <TimerFunctions>
; Global Variable comes first
global TaskNames := []
global TaskDurations := []
global FilePath := A_ScriptDir . "\StopWatchRecords.txt" ; File path to save the log
global TaskName = ""
global StartTime = ""
global Duration = ""
global TaskStartTime = ""
global TaskStopTime = ""
global DebugIncrement = 0

OnExit("ExitCallback", 1)
WelcomeFunction()
#NumPad0::StartStopWatch()
#NumPad1::StopStopWatch()
#NumPad2::ShowTaskRecords()
#NumPad3::RestartTheApp()
#NumPadDot::OpenFileOfRecords()

; ---- For Debugging ----
; 1 day = 86400000 ms
; 50 days = 4320000000 ms
; 24.7 days = 2128800000 ms
; 2147483647ms = 24.8 days
; 1 hour = 3600000 ms
; 1 minute = 60000 ms
;#NumpadAdd::
;    ; Make input box to get a number in a variable then add it to DebugIncrement
;    getIncrement = 0
;    InputBox, getIncrement, Debug Increment, Debug Increment, %DebugIncrement%
;    DebugIncrement := DebugIncrement + getIncrement
;
;return

; ------------------  Archive ------------------
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;#Include %A_ScriptDir%
;; Global Variables comes first
;global TaskNames := []
;global TaskDurations := []
;global FilePath := ""
;global TaskName = ""
;global StartTime = ""
;#Include <TimerFunctions.ahk>
;
;; Main Function
;;#include lib\TimerFunctions.ahk
;WelcomeFunction()
;#NumPad0::StartStopWatch()
;#NumPad1::StopStopWatch()
;#NumPad2::ShowTaskRecords()
;#NumPad3::ClearTaskRecords()
;#NumPadDot::OpenFileOfRecords()
;#Inlcude TimerFunctions
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Message : Task Recorder Has Started Window + NumPad 0 to Start Recording a new Task
; Window + NumPad 1 to Stop Recording
; Window + NumPad 2 to show the Durations of the Recorded Tasks
; Window + NumPad 3 to clear the tasks

; First Start With The Welcome Message and User Manual and FilePath
;WelcomeFunction()

;TaskNames.push("taskjdsk1")
;TaskDurations.push("09:06:24")
;
;TaskNames.push("ts")
;TaskDurations.push("12:06:24")
;
;TaskNames.push("task3")
;TaskDurations.push("09:06:24")
; calculate the duration between the start time and the stop time
;---------
;   if (A_ScreenCount > 1) {
; If there is a second screen
;      ControlGetPos, x, y, w, h, SysListView321
;      screenWidth2 := w
;      screenHeight2 := h
;   }
