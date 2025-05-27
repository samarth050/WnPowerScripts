# Clean-AllTempFiles.ps1
# List of temp directories to clean
$tempPaths = @($env:TEMP, "C:\Windows\Temp")

foreach ($path in $tempPaths) {
    Write-Host "`nCleaning: $path" -ForegroundColor Cyan

    # Delete files
    Get-ChildItem -Path $path -Recurse -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Remove-Item $_.FullName -Force -ErrorAction Stop
            Write-Host "Deleted: $($_.FullName)"
        } catch {
            Write-Warning "Skipped file (in use or access denied): $($_.FullName)"
        }
    }

    # Delete empty folders
    Get-ChildItem -Path $path -Recurse -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Remove-Item $_.FullName -Recurse -Force -ErrorAction Stop
            Write-Host "Deleted folder: $($_.FullName)"
        } catch {
            Write-Warning "Skipped folder (in use or access denied): $($_.FullName)"
        }
    }
}

Write-Host "`nAll temp folders cleaned." -ForegroundColor Green
