$user = "vfontanazzi"
$pass = "Password123$"
$playground = '192.168.12.60'

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Connect-VIServer -Server $playground -User $user -Password  $pass

$datastores = Get-Datastore
 
$datastores | Select-Object name,Datacenter,CapacityGB,FreeSpaceGB | Export-Csv -Path C:\DatastoresSpace.csv

Import-Csv -Path C:\DatastoresSpace.csv
