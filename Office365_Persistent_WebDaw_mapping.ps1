###############
# Tested on Win10, with yourtenant in local intranet zone.
# @vaerpn 12.12.2016
###############
$mappath = '\\yourtenant.sharepoint.com@SSL\DavWWWRoot\SiteAssets' #Replace yourtenant
		NET USE I: $mappath /PERSISTENT:YES
		Sleep -seconds 7  # this is just in case it takes a while

New-Item -Path "HKCU:\Software\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\sharepoint.com\" -Name Vaerpn3 -Force