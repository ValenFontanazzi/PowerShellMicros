$user = "vfontanazzi"
$pass = "Password123$"
$playground = '192.168.12.60'

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Connect-VIServer -Server $playground -User $user -Password  $pass

$todayDate = Get-Date

$WeekBefore = (Get-Date).AddDays(-7)

$snapshots = Get-VM | Get-Snapshot | Where-Object -Property Created -lt $WeekBefore

$snapshots | Select-Object VM, created | Export-Csv -Path C:\Data.csv

Import-Csv -Path C:\ Data.csv


$datastores = Get-Datastore | Get-VM | select name,usedspacegb