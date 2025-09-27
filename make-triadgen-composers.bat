@echo off
cd C:\Users\mike\Documents\gml-workspace\triadgen

echo Creating TriadGen with Composers...

echo ^<!DOCTYPE html^> > triadgen-composers.html
echo ^<html^> >> triadgen-composers.html
echo ^<head^>^<title^>TriadGen Composers^</title^>^</head^> >> triadgen-composers.html
echo ^<body style="font-family:Arial; padding:20px; background:#667eea;"^> >> triadgen-composers.html
echo ^<div style="max-width:800px; margin:auto; background:white; padding:30px; border-radius:10px;"^> >> triadgen-composers.html
echo ^<h1^>TriadGen - 77 Composer Profiles^</h1^> >> triadgen-composers.html
echo ^<select id="composerSelect" style="padding:10px; width:300px;"^>^</select^> >> triadgen-composers.html
echo ^<button onclick="generate()" style="padding:10px;"^>Generate^</button^> >> triadgen-composers.html
echo ^<div id="output" style="margin-top:20px; padding:15px; background:#f0f0f0;"^>^</div^> >> triadgen-composers.html
echo ^<script src="profile-loader.js"^>^</script^> >> triadgen-composers.html
echo ^<script^> >> triadgen-composers.html
echo let profiles = {}; >> triadgen-composers.html
echo loadProfiles().then(p =^> { >> triadgen-composers.html
echo   profiles = p; >> triadgen-composers.html
echo   const s = document.getElementById('composerSelect'); >> triadgen-composers.html
echo   Object.keys(p).forEach(n =^> { >> triadgen-composers.html
echo     const o = document.createElement('option'); >> triadgen-composers.html
echo     o.value = n; o.textContent = n; >> triadgen-composers.html
echo     s.appendChild(o); >> triadgen-composers.html
echo   }); >> triadgen-composers.html
echo }); >> triadgen-composers.html
echo function generate() { >> triadgen-composers.html
echo   const n = document.getElementById('composerSelect').value; >> triadgen-composers.html
echo   const p = profiles[n]; >> triadgen-composers.html
echo   document.getElementById('output').innerHTML = n + ': ' + JSON.stringify(p); >> triadgen-composers.html
echo } >> triadgen-composers.html
echo ^</script^>^</div^>^</body^>^</html^> >> triadgen-composers.html

echo.
echo Created: triadgen-composers.html
echo Opening...
triadgen-composers.html

pause