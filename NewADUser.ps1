param($FirstName, $MiddelInitial, $LastName, $Location = 'OU=Corporate Users', $Tittle)

$DefaultPassword = 'india@123'
$Domainon = (Get-AdDomain).DistinguishedName
$DefaulGroup = 'SecurityGroup-inter'

##Figure ouy what the username Should be
$UserName = "$($FirstName.SubString(0,1))$LastName"
$Eaprebefore = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
if(Get-AdUser $UserName){
     $UserName = "$($FirstName.SubString(0,1))$MiddleInitial$LastName"
     if(Get-AdUser $UserName){
     Write-Warning "No Acccesptable username schema could be created"
     return
     }
}

##Create the user account
$ErrorActionPreference = $Eaprebefore
$NewUserParams = @{
    'UserPrincipalName' = $UserName
    'Name' = $UserName
    'GivenName' = $FirstName
    'Surname' = $LastName
    'Title' = $Tittle
    'SamAccountName' = $UserName
    'AccountPassword' = (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force)
    'Enabled' = $true
    'Initials' = $MiddelInitial
    'Path' = "$Location,$Deomainon"
    'ChangePasswordAtLogon' = $true
}

New-AdUser @NewUserParams

##Add the user account to the company standard Group

Add-ADGroupMember -Identity $DefaulGroup -Members $UserName