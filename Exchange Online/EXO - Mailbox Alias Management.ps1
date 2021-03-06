<#
.SYNOPSIS
Mailbox Alias Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/email-addresses?view=exchserver-2019
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps
#>

<# QUICKRUN: Install and Connect to EXO v2. #>
$Me = "admin@tenantname.onmicrosoft.com";
#Set-ExecutionPolicy RemoteSigned;
Install-Module ExchangeOnlineManagement -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline -UserPrincipalName $me;


<# Add or remove an alias on a specific mailbox.#>
$User = "user@domain.com";
$Alias = "newalias@domain.com";
Set-Mailbox $User -EmailAddresses @{add=$Alias};
Set-Mailbox $User -EmailAddresses @{remove=$Alias};


<# Add multiple aliases from a CSV into a specified mailbox. #>
$User = "user@domain.com";
$PathCsv = "$env:USERPROFILE\Desktop\BulkAddAliasesToMailbox.csv";
Import-Csv $PathCsv | % {Set-Mailbox $User -EmailAddresses @{add=$_.SmtpAddress}};

<# Verify aliases. #>
(Get-Mailbox $User).EmailAddresses
