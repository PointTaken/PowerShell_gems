#############################
# MicrosoftTeams PS Module NB! CURRENTLY IN BETA
# 
# 
# @vaerpn | 2018
# 
#############################

Install-Module -Name MicrosoftTeams -Force
Get-Command -Module MicrosoftTeams


 ##########
 # Example
 #
 # Connect
 ##########
 Connect-MicrosoftTeams
 Disconnect-MicrosoftTeams
 ##########
 #
 # Create Team w.variables
 #
 ##########
     $team = New-Team -Displayname “NOR365C” -Description "Norwegian Office 365 Community Meetup - Oslo" -AccessType Public
# Add user to the Team
    Add-TeamUser -GroupId $team.GroupId -User "seb@vaerpn.com" -Role Owner
    Add-TeamUser -GroupId $team.GroupId -User "Linea@vaerpn.com" -Role Member
    Add-TeamUser -GroupId $team.GroupId -User "thorbjorn.vaerp@pointtaken.no" -Role Member
# Add Channels
    New-TeamChannel -GroupId $team.GroupId -DisplayName "Guest Access"
    New-TeamChannel -GroupId $team.GroupId -DisplayName "Hva skjer med Skype"
    New-TeamChannel -GroupId $team.GroupId -DisplayName "Siste nytt"
#####
# Modify Function settings
#
####
    Set-TeamFunSettings -GroupId $team.GroupId -AllowCustomMemes true
    Get-TeamFunSettings -GroupId $team.GroupId
####
# Remove
####
    Remove-Team -GroupId $team.GroupId
    # cmdlets
 Add-TeamUser
 Get-Team
 Get-TeamChannel
 Get-TeamFunSettings 
 Get-TeamGuestSettings
 Get-TeamMemberSettings
 Get-TeamMessagingSettings
 Get-TeamHelp
 Get-TeamUser
 New-TeamChannel
 New-Team
 Remove-Team
 Remove-TeamChannel
 Remove-TeamUser
 Set-TeamFunSettings
 Set-TeamGuestSettings
 Set-TeamMemberSettings
 Set-TeamMessagingSettings
 Set-Team
 Set-TeamChannel
 Set-TeamPicture