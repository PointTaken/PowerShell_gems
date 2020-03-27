###############################
#
# @vaerpn 24.05.2019
# create hub-sites
# 
# 
##############################
#
# CONNECT TO EXCHANGE
$userCredential = Get-Credential
$ExchSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $userCredential -Authentication Basic -AllowRedirection
Import-PSSession $ExchSession
# CREATE SECURITY DISTRIBUTION GROUPS (ADD MORE HERE) -security and distribution group dynamically
New-Distributiongroup -name "GroupName" -alias "GroupName"  -primarysmtpaddress "groupname@DOMAIN.no" -members member1@DOMAIN.no,member2@DOMAIN.no -type "security"
# REMOVE SESSION
$s = Get-PSSession
Remove-PSSession -Session $s
Disconnect-SPOService

# CONNECT TO SPO
$adminUPN="tv@DOMAIN.no"
$orgName="DOMAIN"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://DOMAIN-admin.sharepoint.com -Credential $userCredential

# CONVERT TO HUB SITE
Register-SPOHubSite https://DOMAIN.sharepoint.com/teams/SharePointhubroot/SitePages/Home.aspx
# Provide the exchange security enabled dist group (Created in EXCHOnline)
# get-spohubsite

# SET SOME PARAMETERS
Set-SPOHubSite -Identity https://DOMAIN.sharepoint.com/teams/SharePointhubroot/ -Description "Main hub site for..."
 # -LogoUrl https://DOMAIN.sharepoint.com/teams/SharePointSaturday/SiteAssets/mylogo.jpg

#Optional Install PnP module
#Install-Module SharePointPnPPowerShellOnline -force
#Get-Module SharePointPnPPowerShell* -ListAvailable | Select-Object Name,Version | Sort-Object Version -Descending

# CONNECT PNP
Connect-PnPOnline –Url https://DOMAIN.sharepoint.com –Credentials (Get-Credential)
# CREATE AND ASSOCIATE
  New-PnPSite -Type TeamSite -title "SPSitename" -alias "SPSiteurl" -Description "SPSiteDesciption"
  Add-SPOHubSiteAssociation -Site https://DOMAIN.sharepoint.com/teams/SPSitename -HubSite https://DOMAIN.sharepoint.com/teams/SharePointhubroot/