cd "D:\FlutterProjects\Home_Cook\canton_connect"
Write-Host "`n=== FLUTTER PROJECT STRUCTURE ===" -ForegroundColor Magenta
Write-Host "Project: $(pwd)" -ForegroundColor Yellow

# Check critical files
Write-Host "`n=== CRITICAL FILES ===" -ForegroundColor Green
@("main.dart", "home_screen.dart", "language_provider.dart") | ForEach-Object {
    $file = Get-ChildItem -Path "lib" -Filter $_ -Recurse
    if ($file) {
        Write-Host "✅ $_" -ForegroundColor Green
        foreach ($f in $file) {
            $relativePath = $f.FullName.Replace("$PWD\", "")
            Write-Host "   📍 $relativePath" -ForegroundColor Cyan
        }
    } else {
        Write-Host "❌ $_" -ForegroundColor Red
    }
}

# Show lib structure
Write-Host "`n=== LIB STRUCTURE ===" -ForegroundColor Yellow
if (Test-Path "lib") {
    Get-ChildItem "lib" -Recurse | Where-Object { 
        $_.FullName.Split('\').Length -le 6 -and $_.FullName -notmatch "backup|build"
    } | Sort-Object FullName | ForEach-Object {
        $depth = $_.FullName.Split('\').Length - 2
        $indent = "  " * $depth
        $icon = if ($_.PSIsContainer) { "📁" } else { "📄" }
        $color = if ($_.Name -eq "main.dart") { "Green" } 
                elseif ($_.Name -eq "home_screen.dart") { "Magenta" }
                elseif ($_.Name -eq "language_provider.dart") { "Blue" }
                else { "White" }
        Write-Host "$indent$icon $($_.Name)" -ForegroundColor $color
    }
}
