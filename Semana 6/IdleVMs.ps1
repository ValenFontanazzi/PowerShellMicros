$user = "vfontanazzi"
$pass = "Password123$"
$playground = '192.168.12.60'

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Connect-VIServer -Server $playground -User $user -Password  $pass

$table = New-Object System.Data.Datatable

$table.Columns.Add("VM","Assigned Cpu","Used Cpu","Assigned Memory","Used Memory")

$vms = Get-VM | Select-Object -Property Name

foreach ($vm in $vms) { 
    $vmdata = get-view –viewtype VirtualMachine –filter @{“Name”=$vm.Name} 
    $vmucpu = $vmdata.Summary.QuickStats.OverallCpuUsage
    if($vmucpu -lt 100){
        
        $vmacpu = $vmdata.Summary.Runtime.MaxCpuUsage
        $vmumem = $vmdata.Summary.QuickStats.GuestMemoryUsage
        $vmamem = $vmdata.Summary.Runtime.MaxMemoryUsage

        $vm.name
        $vmacpu
        $vmucpu
        $vmamem
        $vmumem


        $table.Rows.Add($vmucpu)


    }
}
    
$table | export-csv C:\DataTableJobs.csv 

    #$vmdata = get-view –viewtype VirtualMachine –filter @{“Name”=$vm.name}

    #$vmcpu = $vmdata.Summary.QuickStats

    #$vmcpuassigned = $vmdata.Summary


    #
    

