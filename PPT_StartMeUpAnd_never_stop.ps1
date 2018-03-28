###################################
# POWER POINT StartMeUp and never stop! 
#
# a silly (or handy) litle automated PPPT script
# Simply adjust the path to your PPTX
# then copy the sendkeys and adjust seconds to your preferred timin6
#
# @vaerpn | 2016
# 
####################################

$pptx = "C:\scripts\powershell.pptx" #location of the PPT file to run

$application = New-Object -ComObject powerpoint.application
$presentation = $application.Presentations.open($pptx)
#$application.visible = "msoTrue"
#$presentation.SlideShowSettings.Run()                         
#$presentation.visible = "msoTrue"

[System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
[System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
$Process = Get-Process | where {$_.name -eq "powerpnt"}
[Microsoft.VisualBasic.Interaction]::AppActivate($Process.ID)
Start-Sleep -Seconds 5

[System.Windows.Forms.SendKeys]::SendWait("{F5}")
Start-Sleep -Seconds 5

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 10

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 10

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 10

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 5

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 5

[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Seconds 8

[System.Windows.Forms.SendKeys]::SendWait("{ESC}")
Start-Sleep -Seconds 3

[System.Windows.Forms.SendKeys]::SendWait("%{F4}")
Start-Sleep -Seconds 3
