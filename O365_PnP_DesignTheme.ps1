###############################
#
# @MarlowAndre 03.04.2018
# PnP Design Com Sites
# 
# 
##############################
$cred = Get-Credential
Connect-PnPOnline -Url "https://MYTENANT.sharepoint.com/sites/MYSITE" -Credentials $cred
 
#Change the path, spcolor- and image-files
$path = "%PATH_TO_IMAGE_FILES%"
$spcolor = "MYFRIENDLYNAME.spcolor"
$imageName = "WATERMARK_IMAGE_NAME.jpg"
 
Add-PnPFile -Path ($path+$imageName) -Folder SiteAssets
Add-PnPFile -Path ($path+$spcolor) -Folder SiteAssets
 
$relativeWebUrl = Get-PnPWeb
$relativeWebUrl = $relativeWebUrl.ServerRelativeUrl
$spcolorUrl = $relativeWebUrl+"/SiteAssets/"+$spcolor
$backgroundImageUrl = $relativeWebUrl+"/SiteAssets/"+$imageName
 
Set-PnPTheme -ColorPaletteUrl $spcolorUrl -BackgroundImageUrl $backgroundImageUrl -ResetSubwebsToInherit