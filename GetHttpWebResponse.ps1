######################################
#
# @vaerpn 
# URL Response, list of http status codes: 
# https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
#
# Place URL list file in the below path:
$URLListFile = "c:\scripts\SPUrls.txt"
$URLList = Get-Content $URLListFile -ErrorAction SilentlyContinue

#For every URL in the list
Foreach($Uri in $URLList) {
    try{
        #For proxy systems
        [System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
        [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

        #Web request
        $req = [system.Net.WebRequest]::Create($uri)
        $res = $req.GetResponse()
    }catch {
        #Err handling
        $res = $_.Exception.Response
    }
    $req = $null

    #Getting HTTP status code
    $int = [int]$res.StatusCode

    #Writing on the screen
    Write-Host "$int - $uri"

    #Disposing response if available
    if($res){
        $res.Dispose()
    }
}