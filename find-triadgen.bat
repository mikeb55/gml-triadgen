@echo off
echo ========================================
echo Finding and Updating Latest TriadGen
echo ========================================
echo.

cd /d C:\Users\mike\Documents\gml-workspace\triadgen

echo HTML files in triadgen directory:
echo.
dir /b *.html
echo.

:: Find the main TriadGen file (likely the largest HTML file)
for /f "tokens=*" %%F in ('dir /b /o-s *.html ^| findstr /v "test"') do (
    set MAIN_FILE=%%F
    goto :found
)

:found
echo Main TriadGen file appears to be: %MAIN_FILE%
echo.

:: Create backup
copy "%MAIN_FILE%" "%MAIN_FILE%.backup" >nul
echo Created backup: %MAIN_FILE%.backup
echo.

:: Create composer-enabled version
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo ^<title^>TriadGen with Composers^</title^>
echo ^<style^>
echo body { font-family: Arial; padding: 20px; background: linear-gradient(135deg, #667eea, #764ba2); }
echo .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
echo select, button { padding: 10px; margin: 5px; font-size: 16px; }
echo #output { margin-top: 20px; padding: 15px; background: #f0f0f0; border-radius: 5px; }
echo ^</style^>
echo ^</head^>
echo ^<body^>
echo ^<div class="container"^>
echo ^<h1^>TriadGen - Composer Profiles^</h1^>
echo ^<select id="composerSelect"^>^<option^>Loading composers...^</option^>^</select^>
echo ^<button onclick="generateWithProfile()"^>Generate in Style^</button^>
echo ^<div id="output"^>^</div^>
echo ^</div^>
echo.
echo ^<script src="profile-loader.js"^>^</script^>
echo ^<script^>
echo let allProfiles = {};
echo.
echo loadProfiles().then(profiles =^> {
echo     allProfiles = profiles;
echo     const select = document.getElementById('composerSelect');
echo     select.innerHTML = '';
echo     Object.keys(profiles).forEach(name =^> {
echo         const option = document.createElement('option');
echo         option.value = name;
echo         option.textContent = name + ' (' + profiles[name].category + ')';
echo         select.appendChild(option);
echo     });
echo     console.log('Loaded ' + Object.keys(profiles).length + ' composer profiles');
echo });
echo.
echo function generateWithProfile() {
echo     const selected = document.getElementById('composerSelect').value;
echo     const profile = allProfiles[selected];
echo     document.getElementById('output').innerHTML = 
echo         '^<h3^>' + selected + '^</h3^>' +
echo         '^<p^>Category: ' + profile.category + '^</p^>' +
echo         '^<p^>Techniques: ' + profile.techniques.join(', ') + '^</p^>' +
echo         '^<p^>^<em^>Triad generation in this style...^</em^>^</p^>';
echo }
echo ^</script^>
echo ^</body^>
echo ^</html^>
) > triadgen-composers.html

echo.
echo Created: triadgen-composers.html
echo.
echo Opening in browser...
start triadgen-composers.html

echo.
echo ========================================
echo COMPLETE! Check your browser
echo ========================================
echo.
echo Files created:
echo - triadgen-composers.html (new version with composers)
echo - %MAIN_FILE%.backup (backup of original)
echo.
pause