Function New-AdvancedFunction{
    <#
    .SYNOPSIS

    .EXAMPLE
        PS> New-AdavncedFunction -Param1 MYPARAM

        This example does something to this and that.
    .PARAMETER Param1
        This param does this thing.
    .PARAMATER
    .PARAMETER
    .PARAMETER
    #>
    [CmdletBinding()]
    param(
        [string]$Param1
    )
    process{
        try{
            if ($true) {
                throw 'an error occured'
            }
        } catch {
            Write-Error "$($_.Exception.Message) -Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
}