Function New-EmployeeOnboardUser{
    <#
        .SYNOPSIS
           This function is a part of the Active Directory Account Management Automator tool. It is used to perform all routine
           tasks that must be done when onboarding a new employee user account.
       
        .EXAMPLE
            PS> New-EmployeeOnboardUser -FirstName 'Adam' -MiddleIntialName 'D' -LastName 'Betram' -Title 'Dr. Awsome'

            This example creates an AD username based on company standards into a company-standard OU and adds the user
            into the Company-standard main user group.

        .PARAMETER FirstName
            The first name of the employee.

        .PARAMATER MiddleIntialName
            The middle name of the employee.

        .PARAMETER LastName 
            The last name of the employee

        .PARAMETER Title
            The current job title of the employee
        #>
        [CmdletBinding()]
        param (
            [string]$FirstName,
            [string]$MiddleIntial,
            [string]$LastName,
            [string]$Location = 'OU=Corporate Users',
            [string]$Title
        )
        process {
            ## Not the best use of storing the password clear text
            ## Google/Bing on using stored secure strings on the file system as a way to get around this
            $DefaultPassword = 'india@123'
            $Domainon = (Get-AdDomain).DistinguishedName
            $DefaulGroup = 'SecurityGroup-inter'

            ## Figure ouy what the username Should be
            $UserName = "$($FirstName.SubString(0,1))$LastName"
            ## Check if an existing user already has the first initial/last name username taken
            
            $ErrorActionPreference = 'SilentlyContinue'
             try{
                if (Get-AdUser -Identity $UserName){
                     ## if so, check to see if the first initial/middle initial/last name is taken.
                     $UserName = "$($FirstName.SubString(0,1))$MiddleInitial$LastName"
                     if(Get-AdUser $UserName){
                     throw "No Acccesptable username schema could be created"
                   }
                }
             } catch {
                Write-Error $_.Exception.Message
             }
           
            ##Create the user account
            
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
            $UserName
        
     }
}

Function Set-MyAdUser{

}

Function Set-MyAdComputer{

}

Function New-EmployeeOnboardComputer{

}