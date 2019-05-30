$ErrorActionPreference = "SilentlyContinue"

Write-Host "Hello Welocome" -ForegroundColor Green

$server = Read-Host -Prompt 'Please enter the server name'

$s = New-PSSession -ComputerName $server

Invoke-Command -Session $s -ScriptBlock{ 

do{

Write-Host "*************************************" -ForegroundColor DarkRed
Write-Host "------- Please select a service -----" -ForegroundColor DarkYellow
Write-Host " 1.  Get Stopped Services" -ForegroundColor Green
Write-Host " 2.  Get Running Services" -ForegroundColor Green 
Write-Host " 3.  List All Services" -ForegroundColor Green
Write-Host " 4.  Start Services" -ForegroundColor Green
Write-Host " 5.  Stop Services" -ForegroundColor Green
Write-Host " 6.  Restart Services" -ForegroundColor Green
Write-Host " 7.  Reboot Server" -ForegroundColor Green
Write-Host " 0.  Exit" -ForegroundColor Green
Write-Host "*************************************" -ForegroundColor DarkRed


$getservicename = Read-Host "Please choose a service"

Switch($getservicename)
{
  1 { Get-Service | Where-Object{$_.Status -eq "Stopped"}}
  2 { Get-Service | Where-Object{$_.Status -eq "Running"}}
  3 {Get-Service }
  4 {Startaservice}
  5 {Stopaservice}
  6 {Restartaservice}
  7 {Restart-Computer}
  0 {cls}
}
#Write-Host "*************************************" -ForegroundColor DarkRed
#Write-Host "*************************************" -ForegroundColor DarkRed
#Write-Host " 1.  Start a service " -ForegroundColor Green
#Write-Host " 0.  Exit " -ForegroundColor Green
#Write-Host "*************************************" -ForegroundColor DarkRed
#Write-Host "*************************************" -ForegroundColor DarkRed

#$srname = Read-Host "Please choose a option"

Function Startaservice{
    
    Try{  
       $a= Read-Host "Please enter service name"

       if(Get-Service | Where-Object{$_.DisplayName -eq $a -and $_.Status -eq "Running"})
       {
          Write-Host "-------------------------------" -ForegroundColor Green
          Write-Host "$a Service is already running"
          Write-Host "-------------------------------" -ForegroundColor Green
          Read-Host "Press any key to continue" | Out-Null

       }else{

       Start-Service $a
       Write-Host "Service $a Has been started successfully"
       }
       }catch{
       Write-Host "There was a error in starting the $a Service"
       }
       }

Function Stopaservice{
    Try{

        $b= Read-Host "Please enter service name"

        if(Get-Service | Where-Object{$_.DisplayName -eq $b -and $_.Status -eq "Stopped"})
         {
          Write-Host "-------------------------------" -ForegroundColor Green
          Write-Host "$b Service is already Stopped"
          Write-Host "-------------------------------" -ForegroundColor Green
          Read-Host "Press any key to continue" | Out-Null

         }else{         
      
          Stop-Service $b
          Write-Host "Service $b Has been started successfully"
         }
         }catch{
         Write-Host "There was a error in starting the $b Service"
         }
         }
Function Restartaservice{
    Try{  
       $c= Read-Host "Please enter service name"
       Stop-Service $c
       Write-Host "Service $c Has been started successfully"
       }catch{
       Write-Host "There was a error in starting the $c Service"
       }
       }

}until($getservicename -eq 0)
}
