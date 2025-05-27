# This Power Shell script is used to create a windows executable (.exe) from a python script
# Replace my_script.py with actual python script and icon
$script = "my_script.py"
#If Icon File Uncomment below
#$icon = "app.ico"

Write-Host "Building $script into EXE..."
#If incon file present uncomment below line and comment line 9
#pyinstaller --onefile --noconsole --icon=$icon $script
pyinstaller --onefile --noconsole $script
# Cleanup
Remove-Item -Recurse -Force build, "__pycache__"
Remove-Item -Force "$($script -replace '\.py$', '').spec"

Write-Host "Done. EXE is in the 'dist' folder."
Pause
