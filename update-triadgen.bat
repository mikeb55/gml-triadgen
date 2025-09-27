@echo off
echo ========================================
echo Automating TriadGen Profile Integration
echo ========================================
echo.

cd /d C:\Users\mike\Documents\gml-workspace\triadgen

echo Finding TriadGen HTML files...
for %%F in (*.html) do (
    echo Processing: %%F
    
    :: Create backup
    copy "%%F" "%%F.backup" >nul
    
    :: Check if profile-loader.js is already included
    findstr /C:"profile-loader.js" "%%F" >nul
    if errorlevel 1 (
        echo   Adding profile loader to %%F...
        
        :: Create temporary file with profile loader inserted before </body>
        powershell -Command "(Get-Content '%%F') -replace '</body>', '<script src=\"profile-loader.js\"></script>`n<script>`n  loadProfiles().then(profiles =^> {`n    console.log(''Loaded '' + Object.keys(profiles).length + '' profiles'');`n    window.composerProfiles = profiles;`n  });`n</script>`n</body>' | Set-Content '%%F'"
        
        echo   ✓ Updated %%F
    ) else (
        echo   ✓ Already has profile loader
    )
)

echo.
echo Testing in browser...
echo.

:: Create test file
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>^<title^>TriadGen Profile Test^</title^>^</head^>
echo ^<body^>
echo ^<h1^>TriadGen Profile Integration Test^</h1^>
echo ^<div id="status"^>Loading...^</div^>
echo ^<script src="profile-loader.js"^>^</script^>
echo ^<script^>
echo loadProfiles^(^).then^(profiles =^> {
echo   document.getElementById^('status'^).innerHTML = 
echo     '^<h2 style="color:green"^>✓ SUCCESS^</h2^>^<p^>Loaded ' + 
echo     Object.keys^(profiles^).length + ' profiles^</p^>';
echo }^).catch^(err =^> {
echo   document.getElementById^('status'^).innerHTML = 
echo     '^<h2 style="color:red"^>✗ FAILED^</h2^>^<p^>' + err + '^</p^>';
echo }^);
echo ^</script^>
echo ^</body^>
echo ^</html^>
) > triadgen-profile-test.html

echo Opening test in browser...
start triadgen-profile-test.html

echo.
echo ========================================
echo DONE! Check your browser for test results
echo ========================================
echo.
echo Your TriadGen files have been updated.
echo Backups saved as .backup files
echo.
pause