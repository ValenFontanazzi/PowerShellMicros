$user ="vfontanazzi"
$pass = "Password123$"
$playground = '192.168.12.60'

Set-PowerCLIConfiguration - InvalidCertificateAction Ignore -Confirm: $false
Set-Power CLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm: $false
Connect-VIServer -Server $playground -User $user -Password $pass

$table = New-Object System.Data. Datatable

[void] $table.Columns.Add("VM")
[void] $table.columns.Add("Assigned")
[void] $table.Columns.Add("Used CPU")
[void] $table.Columns.Add("Assigned Memory")
[void] $table.columns.Add("Used Memory")


$vms = Get-VM | select-object -Property Name

foreach ($vm in $vms) {
    $vmdata = get-view -viewtype Virtual Machine -filter @{"Name"=$vm. Name}
    $vmucpu = $vmdata.Summary.Quickstats.OverallCpuusage
    if ($vmucpu -lt 200 -and $vmucpu -ne 0) {

        $vmacpu = $vmdata.Summary.Runtime.MaxCpuusage
        $vmumem = $vmdata.Summary.Quickstats.GuestMemoryusage
        $vmamem = $vmdata.Summary.Runtime.MaxMemoryusage

        [void] $table.Rows.Add($vm. name, $vmacpu, $vmucpu, $vmamem, $vmumem)
    }
}

$table | export-csv C:\Idlevms.csv