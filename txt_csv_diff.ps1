$txt_file = (Get-Content 1.txt) | Sort-Object -Unique

Get-ChildItem "2.csv" | ForEach-Object {
    Import-Csv -Path $_ | Select ITEM | Export-Csv -Append -NoTypeInformation -Path TMP.csv
}

$csv_file = Import-Csv TMP.csv | ForEach-Object { $_.ITEM } | Sort-Object -Unique

$date = Get-Date -Format "yyyyMMdd_HHmmss"

$result = Compare-Object $txt_file $csv_file -PassThru | Tee-Object log/$date.txt

Remove-Item TMP.csv