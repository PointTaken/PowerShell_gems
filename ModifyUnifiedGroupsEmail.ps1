#############################
# Microsoft Office 365
# 
# Change the Unified group email address for an Office 365 Group
# Specify the group name, the new email, and which emails to remove 
#
# @vaerpn | 2018
# 
#############################

 
#The Unified group name you want to change the email in
$groupName = "Support"
#The new email for the Unified group
$newEmail = "newSupport@mydomain.com"
# Specify emails to remove, multiple emails seperated by comma
$removeEmail = "$groupName@vaerpn.com","$groupName@mydomain.onmicrosoft.com"
 
#Prompt for credentials to connect to Exchange Online
Write-Host Connecting to Exchange Online `n Please specify credentials -ForegroundColor Green
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
 
#Get the Unified group
$group = Get-UnifiedGroup | Where-Object {$_.EmailAddresses -like "*$groupName*"}
 
#Change email if the Unified group can be found
if ($group) {
 
# Set new email address
Write-Host Found Unified group: $group.Alias -ForegroundColor Green
Write-Host Setting email address to $newEmail -ForegroundColor Green
Set-UnifiedGroup -Identity $groupName -PrimarySmtpAddress $newEmail
 
# Remove old addresses
Write-Host Removing old email address -ForegroundColor Green `n $removeEmail
Set-UnifiedGroup $groupName -emailaddresses @{remove=$removeEmail}
 
$group = Get-UnifiedGroup | Where-Object {$_.EmailAddresses -like "*$groupName*"}
Write-Host Email addresses now in $groupName : -ForegroundColor Green
$group.EmailAddresses
}
else {
Write-Host "Could not find Unified group with the name $groupName" -ForegroundColor Red
}
 
Remove-PSSession $Session
Write-Host Script complete! -ForegroundColor Green