param ([string]$Computername, [hashtable]$Attributes)

##Attempt to find the ComputerName

try{
   $Computer = Get-AdComputer -Identity $Computername
   if (!$Computer){
   
   ## if the ComputerName Isn't found throw and error and exit
   Write-Host "The Computername '$Computername' does not exist"
   return
}
} catch{

}

## The $Attributes paramter will contain only the parameters for the Set-AdComputer cmdlet
$Computer | Set-AdComputer @Attributes