# Prompt user for source folder
$source = Read-Host "Enter the full path of the source folder"

# Prompt user for destination folder
$destination = Read-Host "Enter the full path of the destination folder"

# Check if source exists
if (-Not (Test-Path -Path $source)) {
    Write-Host "Source folder does not exist." -ForegroundColor Red
    exit
}

# Create destination folder if it doesn't exist
if (-Not (Test-Path -Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
    Write-Host "Destination folder created at: $destination" -ForegroundColor Green
}

# Get all .mp4 files recursively
$mp4Files = Get-ChildItem -Path $source -Filter *.mp4 -Recurse -File

# Move each file to the destination folder
foreach ($file in $mp4Files) {
    $destinationPath = Join-Path -Path $destination -ChildPath $file.Name

    try {
        Move-Item -Path $file.FullName -Destination $destinationPath -Force
        Write-Host "Moved: $($file.FullName) to $destinationPath" -ForegroundColor Cyan
    }
    catch {
        Write-Host "Failed to move: $($file.FullName) - $_" -ForegroundColor Red
    }
}

Write-Host "`nDone moving .mp4 files!" -ForegroundColor Green
