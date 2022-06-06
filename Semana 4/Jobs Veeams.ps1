$jobs = Get-VBRJob 

$table = New-Object System.Data.Datatable
[void]$table.Columns.Add("Job Name","Last Result","Descripcion")

foreach ($job in $jobs)
{
    $name = $job.Name
    $lastresult = $job.GetLastResult()
    $desc = $job.Description
    [void]$table.Rows.Add($name,$lastresult,$desc)
}
$table | export-csv C:\DataTableJobs.csv 