#############################
# Office365 - Windows AD
# Assign license based on AD Groups 
#   
# 
# Copy with pride, but at your own risk!
# @vaerpn | 2018
# 
#############################
#****************************************
# Change the input values below
#
[XML]$groups = Get-Content C:\Scripts\Groups.xml
$sourcegroups = "lic_E3","lic_E5" # Name of the groups which controls license assignment
$onlineusername = "svc_lic@demokunde2.onmicrosoft.com" # Account which connects to Microsoft cloud and can run this script as a scheduled task
$securefile = "C:\scripts\svc_lic_securecred.txt" # Encrypted passwordfile for the user.
$skus = "demokunde2:ENTERPRISEPACK","demokunde2:ENTERPRISEPREMIUM" # Available SKUs
#***********************************************************************************
#
IF ((test-path $securefile) -eq $false)
    {
    read-host -assecurestring | convertfrom-securestring | out-file $securefile # Set securestring with password - only need to run interactively once
    }
$pass = cat $securefile | convertto-securestring # Building credential
$mycred = new-object -typename System.Management.Automation.PSCredential -argumentlist $onlineusername,$pass # Building credential
#*********************************************************************************************
# Sort out group memberships in local AD
foreach ($group in $groups.Groups.Group)
    {
    $adgroup = Get-ADGroup $group.Name
    $members = Get-ADGroupMember $group.Name
    $lic = $group.lic
    IF ($group.Voidgroups -like "")
        {
        $voidgroup = ""
        }
    ELSE 
        {
        $voidgroup = Get-ADGroup -Identity $group.Voidgroups
        }
    foreach ($member in $members)
        {
        IF ($voidgroup -ne "") #Remove groupmembers from Voidgroups
            {
            $RemoveFromVoidUsers = Get-ADGroupMember $group.Name
            foreach ($RemoveFromVoidUser in $RemoveFromVoidUsers)
                {
                $RemoveFromVoid = Get-ADUser $RemoveFromVoidUser -Properties MemberOf
                IF ($RemoveFromVoid.memberof -contains "$($voidgroup.DistinguishedName)") #If member remove from group
                    {
                    Remove-ADGroupMember $voidgroup $RemoveFromVoid -Confirm:$false
                    }
                }
            }
        }
    }
# Connect to cloud and do stuff
Connect-MsolService -Credential $mycred
foreach ($sku in $skus)
    {
    if ($sku -like "demokunde2:ENTERPRISEPACK")
        {
        $adgroup = get-adgroup lic_e3
        $adusers = Get-ADGroupMember $adgroup | Get-ADUser
        $cloudusers = Get-MsolUser | ? {$_.Licenses.accountskuid -like $sku}
        foreach ($clouduser in $cloudusers) 
            { #Removes license for non-group members
            IF ($clouduser.LastDirSyncTime -ne $null) # Checks if the user is cloud-only, if so skip to next user
                {
                $checkmembership = Get-ADUser -Filter * -Properties * | ? {$_.userprincipalname -eq $clouduser.UserPrincipalName}
                if ($checkmembership.memberof -notcontains $adgroup) # Check groupmembership and remove license if the user is not a member
                    {
                    Set-MsolUserLicense -UserPrincipalName $clouduser.UserPrincipalName -RemoveLicenses $sku
                    }
                }
            }
        foreach ($aduser in $adusers)
            {
            $msoluser = Get-MsolUser -UserPrincipalName $aduser.UserPrincipalName 
            IF ($msoluser -ne $null)
                {
                IF ($msoluser.UsageLocation -ne "NO" ) # Check and set locaion "NO" (Norway)
                    {
                    Set-MSOLUser -UserPrincipalName $msoluser.UserPrincipalName -UsageLocation NO
                    }
                IF ($msoluser.Licenses.accountskuid -notcontains $sku) # Check and assign license
                    {
                    Set-MsolUserLicense -UserPrincipalName $msoluser.UserPrincipalName -AddLicenses $sku
                    }
                }
        }
        }
    if ($sku -like "demokunde2:ENTERPRISEPREMIUM")
        {
        $adgroup = get-adgroup lic_e5
        $adusers = Get-ADGroupMember $adgroup | Get-ADUser
        $cloudusers = Get-MsolUser | ? {$_.Licenses.accountskuid -like $sku}
        foreach ($clouduser in $cloudusers) 
            { #Removes license for non-group members
            IF ($clouduser.LastDirSyncTime -ne $null) # Checks if the user is cloud-only, if so skip to next user
                {
                $checkmembership = Get-ADUser -Filter * -Properties * | ? {$_.userprincipalname -eq $clouduser.UserPrincipalName}
                if ($checkmembership.memberof -notcontains $adgroup) # Check groupmembership and remove license if the user is not a member
                    {
                    Set-MsolUserLicense -UserPrincipalName $clouduser.UserPrincipalName -RemoveLicenses $sku
                    }
                }
            }
        foreach ($aduser in $adusers)
            {
            $msoluser = Get-MsolUser -UserPrincipalName $aduser.UserPrincipalName 
            IF ($msoluser -ne $null)
                {
                IF ($msoluser.UsageLocation -ne "NO" ) # Check and set locaion "NO" (Norway)
                    {
                    Set-MSOLUser -UserPrincipalName $msoluser.UserPrincipalName -UsageLocation NO
                    }
                IF ($msoluser.Licenses.accountskuid -notcontains $sku) # Check and assign license
                    {
                    Set-MsolUserLicense -UserPrincipalName $msoluser.UserPrincipalName -AddLicenses $sku
                    }
                }
            }
        }
    }
