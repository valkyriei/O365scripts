<#
.SYNOPSIS
Simple function to generate a full timestamp.

.NOTES
Version Update: 2020-12-13
Author: https://github.com/O365scripts

.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7

.EXAMPLE
$Report | Export-Csv -Encoding utf8 -Path "Report_$(Get-Timestamp).csv";
$Report | Out-File -Encoding utf8 -FilePath "Report_$(Get-Timestamp).txt";
#>

<# Timestamper. #>
function Get-Timestamp {Get-Date -Format "yyyyMMddHHmmss"}
