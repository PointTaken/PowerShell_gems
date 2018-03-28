###############################
#
# @vaerpn 24.08.2017
# Create sitecollection with LocaleID and storage details
# 
############################## 
$cred = Get-Credential
$cred
# Connect to SP Admin in Console
Connect-SPOService -Url https://MyDomain-admin.sharepoint.com -credential $cred
# Create Sitecollection, norwegiaen language and timezone.
New-SPOSite -Owner $cred.UserName -StorageQuota 102400 -Url "https://MyDomain.sharepoint.com/sites/MySite" -LocaleId "1044" -Template "STS#0" -TimeZoneID "4" -Title "Fanzy Title" 