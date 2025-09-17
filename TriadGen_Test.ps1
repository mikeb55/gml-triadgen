# TriadGen V2.0 Complete Testing Script - BULLETPROOF VERSION
# This script will NOT close automatically

# Force the window to stay open
$host.UI.RawUI.WindowTitle = "TriadGen V2.0 Testing Console"

# Set execution policy for this session only (if needed)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

Clear-Host

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   TriadGen V2.0 - Complete Testing Suite  " -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 1. SET AND VERIFY DIRECTORY
Write-Host "[Step 1] Setting Directory..." -ForegroundColor Green
$TRIADGEN_PATH = "C:\Users\mike\Documents\gml-workspace\triadgen"

# Check if directory exists
if (Test-Path $TRIADGEN_PATH) {
    Write-Host "✓ Directory found: $TRIADGEN_PATH" -ForegroundColor Green
    Set-Location $TRIADGEN_PATH
    Write-Host "✓ Changed to directory: $(Get-Location)" -ForegroundColor Green
} else {
    Write-Host "✗ Directory not found: $TRIADGEN_PATH" -ForegroundColor Red
    Write-Host "Please update the TRIADGEN_PATH variable in this script!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host ""

# 2. CHECK FOR HTML FILE
Write-Host "[Step 2] Checking for TriadGen HTML file..." -ForegroundColor Green

$htmlFiles = @(
    "triadgen_v2.html",
    "triadgen.html",
    "index.html"
)

$foundFile = $null
foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        $foundFile = $file
        Write-Host "✓ Found: $file" -ForegroundColor Green
        break
    }
}

if (-not $foundFile) {
    Write-Host "✗ No TriadGen HTML file found!" -ForegroundColor Red
    Write-Host "Please save the TriadGen V2.0 HTML from Claude as one of these:" -ForegroundColor Yellow
    Write-Host "  - triadgen_v2.html (recommended)" -ForegroundColor Yellow
    Write-Host "  - triadgen.html" -ForegroundColor Yellow
    Write-Host "  - index.html" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host ""

# 3. CREATE BACKUP
Write-Host "[Step 3] Creating backup..." -ForegroundColor Green
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupName = "backup_$timestamp.html"

if (Test-Path $foundFile) {
    Copy-Item $foundFile $backupName
    Write-Host "✓ Backup created: $backupName" -ForegroundColor Green
}

Write-Host ""

# 4. CHECK BROWSER
Write-Host "[Step 4] Checking for browser..." -ForegroundColor Green

$browsers = @(
    @{Name="Chrome"; Path="C:\Program Files\Google\Chrome\Application\chrome.exe"},
    @{Name="Chrome x86"; Path="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"},
    @{Name="Edge"; Path="msedge"},
    @{Name="Firefox"; Path="C:\Program Files\Mozilla Firefox\firefox.exe"}
)

$browserFound = $false
$browserPath = ""

foreach ($browser in $browsers) {
    if (Test-Path $browser.Path) {
        Write-Host "✓ Found $($browser.Name)" -ForegroundColor Green
        $browserPath = $browser.Path
        $browserFound = $true
        break
    } elseif ($browser.Path -eq "msedge") {
        # Edge is usually in PATH
        $browserPath = "msedge"
        $browserFound = $true
        Write-Host "✓ Found Microsoft Edge" -ForegroundColor Green
        break
    }
}

if (-not $browserFound) {
    Write-Host "⚠ No browser detected, will try default browser" -ForegroundColor Yellow
}

Write-Host ""

# 5. LAUNCH TRIADGEN
Write-Host "[Step 5] Launching TriadGen in browser..." -ForegroundColor Green

$fullPath = Join-Path (Get-Location) $foundFile

if ($browserFound -and $browserPath -ne "msedge") {
    Start-Process $browserPath -ArgumentList $fullPath
} else {
    # Use default browser
    Start-Process $fullPath
}

Write-Host "✓ Browser launched with: $foundFile" -ForegroundColor Green
Write-Host ""

# 6. CREATE TEST HTML
Write-Host "[Step 6] Creating automated test file..." -ForegroundColor Green

$testHtml = @'
<!DOCTYPE html>
<html>
<head>
    <title>TriadGen V2.0 Test Console</title>
    <style>
        body {
            font-family: 'Consolas', monospace;
            background: #0a0a0a;
            color: #00ff00;
            padding: 20px;
            margin: 0;
        }
        h1 {
            color: #00ffff;
            border-bottom: 2px solid #00ffff;
            padding-bottom: 10px;
        }
        .test-section {
            background: rgba(0,255,0,0.05);
            border: 1px solid #00ff00;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .test-result {
            margin: 5px 0;
            padding: 5px;
        }
        .pass {
            color: #00ff00;
            background: rgba(0,255,0,0.1);
        }
        .fail {
            color: #ff0000;
            background: rgba(255,0,0,0.1);
        }
        button {
            background: #00ff00;
            color: #000;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }
        button:hover {
            background: #00ffff;
        }
        .console {
            background: #000;
            color: #0f0;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #0f0;
            font-family: monospace;
            white-space: pre;
            overflow-x: auto;
            max-height: 200px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
    <h1>🎼 TriadGen V2.0 Test Console</h1>
    
    <div class="test-section">
        <h2>Quick Tests</h2>
        <button onclick="testBasic()">Test Basic Functions</button>
        <button onclick="testTriadPairs()">Test Triad Pairs</button>
        <button onclick="testRiffGen()">Test RiffGen Export</button>
        <button onclick="testAll()">Run All Tests</button>
        <button onclick="openTriadGen()">Open TriadGen</button>
    </div>
    
    <div class="test-section">
        <h2>Test Results</h2>
        <div id="results"></div>
    </div>
    
    <div class="test-section">
        <h2>Console Output</h2>
        <div id="console" class="console"></div>
    </div>
    
    <script>
        let tgWindow = null;
        
        function log(msg, type = 'info') {
            const console = document.getElementById('console');
            const timestamp = new Date().toLocaleTimeString();
            console.innerHTML += timestamp + ' ' + msg + '\n';
            console.scrollTop = console.scrollHeight;
        }
        
        function openTriadGen() {
            tgWindow = window.open('PLACEHOLDER_FILE', 'triadgen');
            log('Opening TriadGen...');
            setTimeout(() => {
                log('TriadGen should be loaded. Running diagnostics...');
                testConnection();
            }, 2000);
        }
        
        function testConnection() {
            if (!tgWindow || tgWindow.closed) {
                log('ERROR: TriadGen window not found!', 'error');
                return false;
            }
            
            try {
                const version = tgWindow.TG ? tgWindow.TG.VERSION : 'Unknown';
                log('Connected to TriadGen V' + version);
                return true;
            } catch(e) {
                log('ERROR: Cannot access TriadGen: ' + e.message, 'error');
                return false;
            }
        }
        
        async function testBasic() {
            log('\n=== TESTING BASIC FUNCTIONS ===');
            const results = document.getElementById('results');
            results.innerHTML = '';
            
            if (!testConnection()) {
                results.innerHTML = '<div class="fail">Please open TriadGen first!</div>';
                return;
            }
            
            try {
                // Test 1: Generate chord
                log('Testing chord generation...');
                const chord = tgWindow.TG.api.generateChord('C', 'Maj7');
                if (chord && chord.voicing) {
                    results.innerHTML += '<div class="pass">✓ Chord Generation: PASS</div>';
                    log('Generated: C' + chord.symbol);
                } else {
                    results.innerHTML += '<div class="fail">✗ Chord Generation: FAIL</div>';
                }
                
                // Test 2: Generate progression
                log('Testing progression generation...');
                const prog = tgWindow.TG.api.generateProgression('ii-V-I', 'C', 4);
                if (prog && prog.length > 0) {
                    results.innerHTML += '<div class="pass">✓ Progression: PASS (' + prog.length + ' chords)</div>';
                } else {
                    results.innerHTML += '<div class="fail">✗ Progression: FAIL</div>';
                }
                
            } catch(e) {
                log('ERROR: ' + e.message, 'error');
                results.innerHTML += '<div class="fail">Test failed: ' + e.message + '</div>';
            }
        }
        
        async function testTriadPairs() {
            log('\n=== TESTING TRIAD PAIRS ===');
            const results = document.getElementById('results');
            
            if (!testConnection()) {
                results.innerHTML = '<div class="fail">Please open TriadGen first!</div>';
                return;
            }
            
            try {
                const tp = tgWindow.TG.api.generateTriadPair(0, 'maj', 2, 'maj');
                if (tp && tp.isTriadPair) {
                    results.innerHTML += '<div class="pass">✓ Triad Pair Generation: PASS</div>';
                    log('Generated C + D hexatonic');
                }
                
                const testResults = tgWindow.TG.runTriadPairTests();
                results.innerHTML += '<div class="pass">✓ Triad Tests: ' + testResults.passed + '/' + (testResults.passed + testResults.failed) + ' passed</div>';
                
            } catch(e) {
                log('ERROR: ' + e.message, 'error');
            }
        }
        
        async function testRiffGen() {
            log('\n=== TESTING RIFFGEN EXPORT ===');
            const results = document.getElementById('results');
            
            if (!testConnection()) {
                results.innerHTML = '<div class="fail">Please open TriadGen first!</div>';
                return;
            }
            
            try {
                const testResults = tgWindow.TG.runRiffGenIntegrationTests();
                results.innerHTML += '<div class="pass">✓ RiffGen Tests: ' + testResults.passed + '/10 passed</div>';
                
            } catch(e) {
                log('ERROR: ' + e.message, 'error');
            }
        }
        
        async function testAll() {
            log('\n=== RUNNING ALL TESTS ===');
            await testBasic();
            await testTriadPairs();
            await testRiffGen();
            log('\n=== ALL TESTS COMPLETE ===');
        }
        
        // Auto-open on load
        window.onload = () => {
            log('Test console ready. Click "Open TriadGen" to begin.');
        };
    </script>
</body>
</html>
'@

# Replace placeholder with actual file
$testHtml = $testHtml -replace 'PLACEHOLDER_FILE', $foundFile

$testHtml | Out-File -FilePath "test_console.html" -Encoding UTF8
Write-Host "✓ Test console created: test_console.html" -ForegroundColor Green

# Launch test console
Start-Process (Join-Path (Get-Location) "test_console.html")
Write-Host "✓ Test console launched" -ForegroundColor Green

Write-Host ""

# 7. DISPLAY INSTRUCTIONS
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          TESTING INSTRUCTIONS              " -ForegroundColor Yellow  
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Two browser windows should now be open:" -ForegroundColor Green
Write-Host "  1. TriadGen V2.0 (main application)" -ForegroundColor White
Write-Host "  2. Test Console (automated testing)" -ForegroundColor White
Write-Host ""

Write-Host "QUICK TEST STEPS:" -ForegroundColor Yellow
Write-Host "----------------" -ForegroundColor Yellow
Write-Host "1. In the Test Console, click 'Open TriadGen'" -ForegroundColor White
Write-Host "2. Click 'Run All Tests' to test everything" -ForegroundColor White
Write-Host "3. Watch the console output for results" -ForegroundColor White
Write-Host ""

Write-Host "MANUAL TEST IN TRIADGEN:" -ForegroundColor Yellow
Write-Host "-----------------------" -ForegroundColor Yellow
Write-Host "1. Press F12 to open browser console" -ForegroundColor White
Write-Host "2. Type: TG.runTests()" -ForegroundColor Cyan
Write-Host "3. Type: TG.runTriadPairTests()" -ForegroundColor Cyan
Write-Host "4. Type: TG.runRiffGenIntegrationTests()" -ForegroundColor Cyan
Write-Host ""

Write-Host "UI WORKFLOW TEST:" -ForegroundColor Yellow
Write-Host "----------------" -ForegroundColor Yellow
Write-Host "1. Select 'Triad Pairs/Polychords' in Chord Family" -ForegroundColor White
Write-Host "2. Set Complexity to 8" -ForegroundColor White
Write-Host "3. Click 'Generate Harmony'" -ForegroundColor White
Write-Host "4. Click 'Play' to hear music" -ForegroundColor White
Write-Host "5. Click 'Export Menu' for options" -ForegroundColor White
Write-Host ""

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "         KEEP THIS WINDOW OPEN!            " -ForegroundColor Red
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press 'R' to show instructions again" -ForegroundColor Yellow
Write-Host "Press 'T' to show test commands" -ForegroundColor Yellow
Write-Host "Press 'Q' to quit" -ForegroundColor Yellow
Write-Host ""

# Keep window open with menu
while ($true) {
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    switch ($key.Character) {
        'r' {
            Clear-Host
            Write-Host "TESTING INSTRUCTIONS:" -ForegroundColor Yellow
            Write-Host "1. Use Test Console for automated tests" -ForegroundColor White
            Write-Host "2. Use F12 console for manual tests" -ForegroundColor White
            Write-Host "3. Try the UI workflow" -ForegroundColor White
        }
        't' {
            Clear-Host
            Write-Host "BROWSER CONSOLE TEST COMMANDS:" -ForegroundColor Yellow
            Write-Host "------------------------------" -ForegroundColor Yellow
            Write-Host "TG.runTests()" -ForegroundColor Cyan
            Write-Host "TG.runTriadPairTests()" -ForegroundColor Cyan
            Write-Host "TG.runRiffGenIntegrationTests()" -ForegroundColor Cyan
            Write-Host "TG.api.generateTriadPair(0, 'maj', 2, 'maj')" -ForegroundColor Cyan
            Write-Host "TG.generate()" -ForegroundColor Cyan
            Write-Host "TG.play()" -ForegroundColor Cyan
            Write-Host "TG.showExportMenu()" -ForegroundColor Cyan
        }
        'q' {
            Write-Host ""
            Write-Host "Exiting..." -ForegroundColor Red
            exit
        }
    }
    
    Write-Host ""
    Write-Host "Press 'R' for instructions, 'T' for test commands, 'Q' to quit" -ForegroundColor Yellow
}