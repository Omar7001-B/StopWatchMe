#Requires AutoHotkey v1.1
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SetWorkingDir, %A_ScriptDir%
#Include <TimerFunctions>
; Global Variable comes first
global TaskNames := []
global TaskDurations := []
global FilePath := A_ScriptDir . "\LoggerFile.txt" ; File path to save the log
global TaskName = "" ,StartTime = ""

WelcomeFunction()
#NumPad0::StartStopWatch()
#NumPad1::StopStopWatch()
#NumPad2::ShowTaskRecords()
#NumPad3::ClearTaskRecords()
#NumPadDot::OpenFileOfRecords()



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
