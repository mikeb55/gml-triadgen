@echo off
echo Cleaning up TriadGen directory...
echo.

cd /d C:\Users\mike\Documents\gml-workspace\triadgen

echo Moving backups to backup folder...
mkdir backups 2>nul
move *.backup backups\ 2>nul

echo.
echo Committing the important files...
git add profile-loader.js
git add triadgen-composers-fixed.html
git add test-now.html
git add *.bat

git commit -m "Add profile integration and composer selection to TriadGen"
git push

echo.
echo ========================================
echo SUMMARY OF TODAY'S ACCOMPLISHMENTS:
echo ========================================
echo.
echo 1. Created centralized profile system (77+ profiles)
echo 2. Pushed to GitHub: GML-Composer-Profiles-Extension
echo 3. Integrated profiles into 11 apps
echo 4. Built TriadGen with composer selection
echo 5. Fixed MusicXML export for Sibelius
echo 6. Everything backed up to GitHub
echo.
echo Your ecosystem is now connected and version controlled!
echo ========================================
pause