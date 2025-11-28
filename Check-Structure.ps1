# Check-Structure.ps1
Write-Host "?? Checking Flutter Project Structure..." -ForegroundColor Cyan

# Define expected structure
$ExpectedStructure = @(
    "lib\",
    "lib\main.dart",
    "lib\app.dart",
    "lib\core\",
    "lib\core\constants\",
    "lib\core\constants\app_constants.dart",
    "lib\core\themes\",
    "lib\core\themes\app_theme.dart",
    "lib\core\utils\",
    "lib\data\",
    "lib\data\models\",
    "lib\data\repositories\",
    "lib\domain\",
    "lib\domain\entities\",
    "lib\domain\usecases\",
    "lib\presentation\",
    "lib\presentation\screens\",
    "lib\presentation\widgets\",
    "lib\presentation\providers\",
    "lib\presentation\navigation\"
)

# Check each item
$MissingItems = @()
$ExistingItems = @()

Write-Host "`n?? Checking Structure..." -ForegroundColor Yellow
foreach ($item in $ExpectedStructure) {
    if (Test-Path $item) {
        $ExistingItems += $item
        Write-Host "  ? $item" -ForegroundColor Green
    } else {
        $MissingItems += $item
        Write-Host "  ? $item" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n?? Summary:" -ForegroundColor Cyan
Write-Host "  Total Expected: $($ExpectedStructure.Count)" -ForegroundColor White
Write-Host "  Found: $($ExistingItems.Count)" -ForegroundColor Green  
Write-Host "  Missing: $($MissingItems.Count)" -ForegroundColor Red

if ($MissingItems.Count -gt 0) {
    Write-Host "`n? Missing Items:" -ForegroundColor Red
    $MissingItems | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    
    # Ask to create missing structure
    $create = Read-Host "`nCreate missing structure? (y/n)"
    if ($create -eq 'y') {
        foreach ($item in $MissingItems) {
            if ($item.EndsWith("\")) {
                New-Item -Path $item -ItemType Directory -Force | Out-Null
                Write-Host "  ?? Created: $item" -ForegroundColor Green
            } else {
                $dir = Split-Path $item -Parent
                if (!(Test-Path $dir)) {
                    New-Item -Path $dir -ItemType Directory -Force | Out-Null
                }
                # Create basic Dart file
                $fileName = Split-Path $item -Leaf
                $content = "// $fileName`nclass $(($fileName -replace '\.dart','' -replace '_','' -replace '-','')) {`n  // TODO: Implement`n}"
                Set-Content -Path $item -Value $content
                Write-Host "  ?? Created: $item" -ForegroundColor Green
            }
        }
    }
}
