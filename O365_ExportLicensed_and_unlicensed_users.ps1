###############################
#
#
# admin@espc16.onmicrosoft.com
# Passw0rd2016
#
# 
##############################
#
#Connect to MSOL
# Create a variable $cred
$Cred = Get-Credential
Connect-MsolService -Credential $cred
# E3, E5, Small Business etc
Get-MsolAccountSku

# lookilook
Get-MsolUser

# New dude 
New-MsolUser -UserPrincipalName Eric@espc16.onmicrosoft.com -DisplayName Eric -firstname Eric -LastName Cantona -Department "Espc16" -Password "Passw0rd2016" -UsageLocation AT -LicenseAssignment "espc16:ENTERPRISEPREMIUM"  -PreferredDataLocation EUR
Remove-MsolUser -UserPrincipalName Eric@espc16.onmicrosoft.com -Force
# Bulk Import from .csv
# -DisplayName,FirstName,LastName,UserPrincipalName,Department,PassWord,UsageLocation,LicenseAssignment
#
$users = Import-Csv C:\scripts\Users.CSV
$users | ForEach-Object {
New-MsolUser -DisplayName $_.DisplayName -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UserPrincipalName -Department $_.Department -PassWord $_.PassWord -UsageLocation $_.UsageLocation -LicenseAssignment $_.LicenseAssignment } | Export-Csv -Path C:\scripts\SPOUsersCSV.csv -NoTypeInformation
#
#
#
#Bulk delete
#
$users = Import-Csv C:\scripts\users.csv 
$users| foreach-object {
Remove-MsolUser -UserPrincipalName $_.userprincipalname -Force}
#
#
#
#
#
#
