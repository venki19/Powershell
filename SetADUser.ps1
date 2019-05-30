param ([string]$username, [hashtable]$Attributes)

try{
   ## Attempt to find the username
   $UserAccount = Get-AdUser -Identity $username
   if(!$UserAccount){
      ## If the Username isn't found throw an error and exit
      Write-Error "The Username '$username'does not exist"
      return
   }
} catch {

}

## The $Attribute parameter will contain only the parameters for the Set-AdUser cmdlet other than
## Password. If this is in $Attributes it needs to be treated differently.

if ($Attributes.ContainsKey('Password')){
    $UserAccount | Set-ADAccountPassword -Reset -NewPassword (ConvrtTo-SecureString - AsPlainTest $Attributes.Password -Force)
    ## Remove the paasword key because we'll be passing this hastable directly to Set-AdUser later
}

$UserAccount | Set-AdUser @Attributes