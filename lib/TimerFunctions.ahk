#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.

;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
Menu, Tray, Icon, Shell32.dll, 175	; also changes Inputbox icon

; ------------------ (HOTKEY) Start Stop Watch (#0)-------------------------------
StartStopWatch(){
   ; InputBox, Prompt, HIDE, Width, Height, X, Y, Locale, TimeOut, Defualt

   if (TaskName == "") {
      InputBox, TaskName, Enter task name, Enter Your Task Name , TaskName , 320, 100
      ; append curTime in FileePath, with a message At (curTime) TaskName Started
      while(TaskName == "" && ErrorLevel = 0) { ; while clicking ok without filling the field
         InputBox, TaskName, TaskName Can't Be Empty , , TaskName , 320, 100
      }
      If ErrorLevel ; if he calick cancel or close
      {
         ; The user clicked "Cancel"
         DisplayTooltip("Canceled")
         TaskName := ""
      }
      Else{
         TaskStartTime := getCurrentTime()
         StartTime := A_TickCount
         DisplayTooltip("Task started: " . TaskName)
         ;FileAppend, `nAt %TaskStartTime% [%TaskName%], %FilePath%
         setUpdateTimer(1000) ;; caling the function to update the timer of current task
         ;      SetTimerTone(5)
      }
   }
   else {
      varSaveTaskName := TaskName
      InputBox, TaskName, Rename Or Delete By Leaving it Empty . , Enter Your Task Name , TaskName , 320, 100,,,,,%TaskName%
      if(TaskName == "")
      {
         DisplayTooltip("Task Deleted")
         FileAppend, `nDeleted [%varSaveTaskName%] at %Duration%, %FilePath%
      }
      else if (varSaveTaskName != TaskName)
      {
         DisplayTooltip("Task Renamed: " . varSaveTaskName . " to " . TaskName)
         FileAppend, `n[%varSaveTaskName%] --> [%TaskName%] %Duration%, %FilePath%
      }
   }
   return
}

; ------------------ (HOTKEY) Stop Stop Watch (#1)-------------------------------
StopStopWatch(){
   if (TaskName != "") {
      stopTime := A_TickCount
      TaskStopTime := getCurrentTime()
      DisplayTooltip("✓ ["TaskName . "]: " . Duration . ")")
      ;; I removed the word Finished to make the log has few words
      FileAppend, `n%TaskStartTime% - %TaskStopTime% [%TaskName%] %Duration%, %FilePath%
      ; push the task name and Duration in the taskRecords array and then clear the TaskName variable
      TaskNames.push(TaskName)
      TaskDurations.push(Duration)
      TaskName := ""
   }
   return
}

; ------------------ (HOTKEY) Show Task Records (#2)-------------------------------
ShowTaskRecords(){
   ; build the output in a string and then display it in a message box
   output := ""
   for i, tName in TaskNames
   {
      ; make the setw to 20 and the setfill to space
      output .= TaskDurations[i]
      ; get size of TaskNames[i]
      output .= SubStr(" ", 1, 10)
      ; if size is less than 20 then add spaces to the end of the string
      output .= TaskNames[i] . "`n"
   }
   MsgBox, % output
   return
}
; ------------------ (HOTKEY) Clear Task Records (#3)-------------------------------
RestartTheApp(){
   ; clear everything and reset the variables
   ; show Msg box are you sure?
   MsgBox, 4, Restart StopWatchMe?, Are you sure you want to restart StopWatchMe?
   IfMsgBox, Yes
   {
      FileAppend, `nRestarted Successfully, %FilePath%
      Reload
   }
   return
}

; ------------------ (HOTKEY) Open File Of Reocrds (#.)-------------------------------
OpenFileOfRecords(){
   if(FilePath != ""){
      run, %FilePath%
      DisplayTooltip("File opened")
   }else {
      DisplayTooltip("File path is empty")
   }
   return
}

; ------------------(FUNCTION) The Welcome Message-------------------------------
WelcomeFunction()
{
   contents := "" ; Contents of the file
   msgBoxText := "" ; Text to display in the message box
   ;    FilePath := "" ; Path to the file

   currentDateTime := "" ; Current date and time
   FormatTime, currentDateTime, , MMMM d, yyyy

   ; ------------------ Welcome Message -------------------------------
   msg1 = Task Recorder Has Started (MadeBy: @OmarAbbas)
   msg2 = Window + NumPad 0 to Start Recording a new Task
   msg3 = Window + NumPad 1 to Stop Recording
   msg4 = Window + NumPad 2 to show the Durations of the Recorded Tasks
   msg5 = Window + NumPad 3 to Restart The Program
   msg6 = Window + NumPad . to open the StopWatchRecords.txt file

   msgBoxText := msg1 . "`n" . msg2 . "`n" . msg3 . "`n" . msg4 . "`n" . msg5 . "`n" . msg6
   ;I removed the welcome message because it's a little annoying //-//
   ;MsgBox, 0, Welcome, %msgBoxText%

   ; --------- Adding Date To The File And Removing Multiples Space Lines-----------
   FileRead, contents, %FilePath%
   contents := RegExReplace(contents, "`a)\R+", "`n")
   FileDelete, %FilePath%
   FileAppend, %contents%, %FilePath%
   if (!InStr(contents, currentDateTime) > 0)
   {
      FormatTime, currentDateTime, , MMMM d, yyyy
      FileAppend, `n %currentDateTime%, %FilePath%
   }
   return
}

; ------------------ (FUNCTION) Display Tooltip-------------------------------
DisplayTooltip(text) {
   screenWidth1 := A_ScreenWidth
   screenHeight1 := A_ScreenHeight
   screenWidth2 := A_ScreenWidth
   screenHeight2 := A_ScreenHeight

   ; Calculate the position of the tooltip
   tooltipX := screenWidth1 + screenWidth2
   tooltipY := A_ScreenHeight - 50 ; Down Left Corner

   ; Display the tooltip
   ToolTip, %text%, %tooltipX%, %tooltipY%
   return
}

; ------------------(FUNCTION) Calculate Duration-------------------------------
CalculateDuration(StartTime, stopTime) {
   d := stopTime - startTime + DebugIncrement

   if(d < 0)
      d += 2147483647

   if(d//3600000 > 23)
      return Format("{:02}:{:02}:{:02}:{:02}", d//86400000, MOD(d // 3600000,24), Mod(d // 60000, 60), Mod(d // 1000, 60))

   return Format("{:02}:{:02}:{:02}", d // 3600000, Mod(d // 60000, 60), Mod(d // 1000, 60))
}

setUpdateTimer(miliSeconds)
{
   SetTimer, UpdateTooltip, %miliSeconds%

   UpdateTooltip:
      Duration := CalculateDuration(StartTime, A_TickCount)
      if(TaskName != ""){
         DisplayTooltip("[" . TaskName . "] : " . Duration)
      }
   return
}

; ------------------(FUNCTION) Get Current Time-------------------------------

getCurrentTime(){
   FormatTime, MyTime,, hh:mm tt
   return MyTime
}

ExitCallback(ExitReason, ExitCode) {
   if (TaskName != "") {
      TaskStopTime := getCurrentTime()
      FileAppend % "`n" TaskStartTime " - " TaskStopTime " [" TaskName "] " Duration " Closed", % FilePath
   }
}