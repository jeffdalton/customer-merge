Write-Host "Start Customer-Merge data load @ $(Get-Date)"

$base_dir=(Get-Location).ToString() + "\"
$build_dir = "build\"
$script_dir = "scripts\"
$import_merge_list_file = $base_dir + "data\B_Final_Filtered_Merge_List.csv"
$import_nondealsupport_list_file = $base_dir + "data\IM_NDS_Customers.csv"
$build_script = $build_dir + "build.sql"
$import_merge_list_script =  $script_dir + "import_merge_list.sql"
$import_nondealsupport_list_script = $script_dir + "import_NonDealSupport_list.sql"
$normalize_nondealsupport_list_script = $script_dir + "normalize_nondealsupport.sql"
$normalize_merge_list_script = $script_dir + "normalize_merge_list.sql"

if (Test-Path -d $build_dir)
{
    Remove-Item $build_dir -Force -Recurse | Out-Null
}
New-Item -ItemType Directory -Path $build_dir | Out-Null

(Get-Content $import_merge_list_script).Replace("[IMPORT_FILE]", $import_merge_list_file) |
    Add-Content $build_script

(Get-Content $import_nondealsupport_list_script).Replace("[IMPORT_FILE]", $import_nondealsupport_list_file) |
    Add-Content $build_script


(Get-Content $normalize_merge_list_script) |
    Add-Content $build_script

(Get-Content $normalize_nondealsupport_list_script) | 
    Add-Content $build_script



psql -f $build_script customer_merge
if(!$?)
{
    "Fail Customer-Merge data load @ $(Get-Date)"
    exit 99
}

Write-Host "Finish Customer-Merge data load @ $(Get-Date)"