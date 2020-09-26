<#
.SYNOPSIS
.NOTES
.LINK
#>

<# Pull the list of devices where the last login was more than X days and delete the selected ones. #>
$Days = 60;
$DatePast = Get-Date $((Get-Date).AddDays(-$Days));
Write-Host -NoNewline "Gathering list of AAD devices not used from "; Write-Host -NoNewline -Fore Yellow (Get-Date $DatePast -Format "yyyy-MM-dd HH:mm:ss"); Write-Host " until now...";
$ListDevices = Get-AzureADDevice | Where {$_.ApproximateLastLogonTimeStamp -lt $DatePast}
$ListDevices | Where {$_.ApproximateLastLogonTimeStamp -le $DatePast} | Select DisplayName,AccountEnabled,ApproximateLastLogonTimeStamp,DeviceOSType,DeviceOSVersion,DeviceTrustType,IsCompliant,IsManaged,LastDirSyncTime,ProfileType,SystemLabels,DeviceId,ObjectId | Out-GridView -PassThru;
$ListDevicesToRemove = $ListDevices | Where {$_.ApproximateLastLogonTimeStamp -le $DatePast} | Select DisplayName,AccountEnabled,ApproximateLastLogonTimeStamp,DeviceOSType,DeviceOSVersion,DeviceTrustType,IsCompliant,IsManaged,LastDirSyncTime,ProfileType,SystemLabels,DeviceId,ObjectId | Out-GridView -PassThru;
$ListDevicesToRemove | % {Remove-AzureADDevice -ObjectId $_.ObjectId;}
