###############################
#
# @vaerpn 03.02.2017
# Bulk add users to O365 with a report file, same report file can be used to delete some/all later 
# All files are stored inside Office365 SiteAssets on root for versioning and metadata
# 
##############################
#
#PART 1 - Connect to MSOL
$Cred = Get-Credential # Create a variable $cred
Connect-MsolService -Credential $cred
# E3, E5, Small Business etc
Get-MsolAccountSku
# 
# lookilook
# Get-MsolUser
#
# PART2 Map network drive against O365
$mappath = '\\aspc2017.sharepoint.com@SSL\DavWWWRoot\SiteAssets' #Replace yourtenant
		NET USE I: $mappath /PERSISTENT:YES
		Sleep -seconds 7  # this is just in case it takes a while
# Set working directory to mapped drive
cd i:\
# PART 3 Bulkimport Users
# -DisplayName,FirstName,LastName,UserPrincipalName,Department,PassWord,UsageLocation,LicenseAssignment
#
$users = Import-Csv "Users.CSV"
$users | ForEach-Object {
New-MsolUser -DisplayName $_.DisplayName -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UserPrincipalName -Department $_.Department -PassWord $_.PassWord -UsageLocation $_.UsageLocation -LicenseAssignment $_.LicenseAssignment } | Export-Csv -Path "\UsersAdded\MatrixUsersCSV.csv" -NoTypeInformation
#
#
# OPTIONAL PART 4
#####################
#XXX Bulk delete XXXX
#####################
# Remove the # if you like to delete the  users from the export file
# $users = Import-Csv C:\Workspaces\Users\users.csv
# $users| foreach-object {
# Remove-MsolUser -UserPrincipalName $_.userprincipalname -Force}
#
####
# XXX Delete non licensed users XXX
# Get-MsolUser -All -UnlicensedUsersOnly | Remove-MsolUser -Force