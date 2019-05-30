param($ComputerName, $Location = 'OU=Corporate Computers')

try{
    if (Get-ADComputer $ComputerName){
        Write-Error "The Computer Name '$ComputerName' Already Exists"
        return
    }
} catch{

}
$DomainOn = (Get-ADDomain).DistinguishedName
$DefaultOuPath = "$Location,$DomainOn"

New-ADComputer -Name $ComputerName -Path $DefaultOuPath