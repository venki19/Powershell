. C:\Users\Rathoven\Documents\powershell\AdAccountManagementAutomator.ps1

$Employees = Import-Csv -Path C:\Users\Rathoven\Documents\powershell\Users.csv
foreach ($Employees in $Employees){
    try {
        ## Create the AD Usser accounts
        $NewUserParams = @{
            'FirstName' = $Employee.FirstName
            'MiddleInitial' = $Employee.MiddleInitial
            'LastName' = $Employee.LastName
            'Title' = $Employee.Title
        }
        if ($Employee.Location) {
            $NewUserParams.Location = $Employee.Location
        }
        ## Grab the username created to use for Set-MyAdUser
        $Username = New-EmployeeOnboardUser @NewUserParams

        ## Create the employee's AD Computer account
        New-EmployeeOnboardComputer -ComputerName $Employee.Computername

        ## Set the description for the employee's computer account
        Set-MyAdComputer -Computername $Employee.Computername -Attributes @{'Description' = "$($Employee.FirstName) $($Employee.LastName)'s computer"}

        ## Set the dept the employee is in
        Set-MyAdUser -UserName $Username -Attributes @{'Department' = $Employee.Department}

    } catch {
        Write-Error "$($_.Exception.Message) -Line Number: $($_.InvocationInfo.ScriptLineNumber)"
    }
}