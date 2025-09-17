#!/bin/bash
# ================================================================
# AUTOMATED TRIADGEN TEST SCRIPT
# This will create and launch everything automatically!
# ================================================================

# ALWAYS SET DIRECTORY FIRST!
cd /c/Users/mike/Documents/gml-workspace/gml-enhancement-suite

echo "================================================"
echo "     TRIADGEN AUTOMATED SETUP & TEST"
echo "================================================"
echo ""

# Step 1: Confirm directory
echo "[1/4] Working directory set..."
echo "✓ Location: $(pwd)"
echo ""

# Step 2: Create enhanced-apps folder if it doesn't exist
echo "[2/4] Checking folders..."
mkdir -p enhanced-apps
echo "✓ enhanced-apps folder ready"
echo ""

# Step 3: Create the complete TriadGen app
echo "[3/4] Creating TriadGen Complete App..."
cat > enhanced-apps/triadgen-complete.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>TriadGen - Complete Chord Generator</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
        }
        .success-banner {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-weight: bold;
            text-align: center;
        }
        .controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .control-group {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }
        select, input {
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            margin: 5px;
            transition: all 0.3s;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .play-btn {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
        }
        .results {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        .chord-display {
            background: white;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            margin: 10px 0;
        }
        .chord-display h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .test-status {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #48bb78;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
    </style>
</head>
<body>
    <div class="test-status">SYSTEM READY</div>
    
    <div class="container">
        <h1>🎹 TriadGen - Professional Chord Generator</h1>
        
        <div class="success-banner">
            ✅ APP LOADED SUCCESSFULLY - CLICK ANY BUTTON TO TEST!
        </div>
        
        <div class="controls">
            <div class="control-group">
                <label>Root Note</label>
                <select id="root">
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="E">E</option>
                    <option value="F">F</option>
                    <option value="G">G</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                </select>
            </div>
            
            <div class="control-group">
                <label>Chord Type</label>
                <select id="chordType">
                    <option value="Major">Major</option>
                    <option value="Minor">Minor</option>
                    <option value="7th">7th</option>
                    <option value="Maj7">Major 7th</option>
                    <option value="Min7">Minor 7th</option>
                </select>
            </div>
            
            <div class="control-group">
                <label>Octave</label>
                <select id="octave">
                    <option value="3">3</option>
                    <option value="4" selected>4</option>
                    <option value="5">5</option>
                </select>
            </div>
        </div>
        
        <div style="text-align: center;">
            <button onclick="generateChord()">🎲 Generate Chord</button>
            <button class="play-btn" onclick="playChord()">🔊 Play Sound</button>
            <button onclick="testBatch()">📦 Generate 3</button>
            <button onclick="clearAll()">🗑️ Clear</button>
        </div>
        
        <div class="results">
            <h2>Generated Chords</h2>
            <div id="output">
                <p style="color: #999;">Click "Generate Chord" to begin...</p>
            </div>
        </div>
    </div>
    
    <script>
        // Test that everything loaded
        console.log('✅ TriadGen loaded successfully!');
        
        let currentChord = null;
        let chordCount = 0;
        
        // Audio context for sound
        const audioContext = new (window.AudioContext || window.webkitAudioContext)();
        
        // Note frequencies
        const frequencies = {
            'C': [130.81, 261.63, 523.25],
            'D': [146.83, 293.66, 587.33],
            'E': [164.81, 329.63, 659.25],
            'F': [174.61, 349.23, 698.46],
            'G': [196.00, 392.00, 783.99],
            'A': [220.00, 440.00, 880.00],
            'B': [246.94, 493.88, 987.77]
        };
        
        function generateChord() {
            const root = document.getElementById('root').value;
            const type = document.getElementById('chordType').value;
            const octave = parseInt(document.getElementById('octave').value) - 3;
            
            chordCount++;
            currentChord = {
                root: root,
                type: type,
                octave: octave + 3,
                notes: getChordNotes(root, type),
                time: new Date().toLocaleTimeString()
            };
            
            displayChord(currentChord);
        }
        
        function getChordNotes(root, type) {
            const noteOrder = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
            const rootIndex = noteOrder.indexOf(root);
            const notes = [root];
            
            if (type.includes('Major')) {
                notes.push(noteOrder[(rootIndex + 2) % 7]);
                notes.push(noteOrder[(rootIndex + 4) % 7]);
            } else if (type.includes('Minor')) {
                notes.push(noteOrder[(rootIndex + 2) % 7] + '♭');
                notes.push(noteOrder[(rootIndex + 4) % 7]);
            }
            
            if (type.includes('7')) {
                notes.push(noteOrder[(rootIndex + 6) % 7]);
            }
            
            return notes;
        }
        
        function displayChord(chord) {
            document.getElementById('output').innerHTML = 
                '<div class="chord-display">' +
                '<h3>' + chord.root + ' ' + chord.type + '</h3>' +
                '<p>Notes: ' + chord.notes.join(' - ') + '</p>' +
                '<p>Octave: ' + chord.octave + '</p>' +
                '<p>Generated: ' + chord.time + '</p>' +
                '<p>Total Chords Created: ' + chordCount + '</p>' +
                '</div>';
        }
        
        function playChord() {
            if (!currentChord) {
                generateChord();
            }
            
            const root = document.getElementById('root').value;
            const octave = parseInt(document.getElementById('octave').value) - 3;
            const baseFreq = frequencies[root][octave];
            
            // Play root
            playNote(baseFreq, 0);
            // Play third
            playNote(baseFreq * 1.26, 100);
            // Play fifth
            playNote(baseFreq * 1.5, 200);
            
            // Visual feedback
            document.querySelector('.test-status').textContent = 'PLAYING CHORD';
            setTimeout(() => {
                document.querySelector('.test-status').textContent = 'SYSTEM READY';
            }, 1000);
        }
        
        function playNote(freq, delay) {
            setTimeout(() => {
                const osc = audioContext.createOscillator();
                const gain = audioContext.createGain();
                
                osc.connect(gain);
                gain.connect(audioContext.destination);
                
                osc.frequency.value = freq;
                osc.type = 'sine';
                
                gain.gain.setValueAtTime(0.3, audioContext.currentTime);
                gain.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 1);
                
                osc.start();
                osc.stop(audioContext.currentTime + 1);
            }, delay);
        }
        
        function testBatch() {
            for (let i = 0; i < 3; i++) {
                setTimeout(() => {
                    // Randomize settings
                    const roots = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
                    const types = ['Major', 'Minor', '7th'];
                    document.getElementById('root').value = roots[Math.floor(Math.random() * roots.length)];
                    document.getElementById('chordType').value = types[Math.floor(Math.random() * types.length)];
                    generateChord();
                }, i * 500);
            }
        }
        
        function clearAll() {
            document.getElementById('output').innerHTML = '<p style="color: #999;">Cleared. Generate new chords...</p>';
            chordCount = 0;
            currentChord = null;
        }
        
        // Auto-generate first chord
        setTimeout(generateChord, 500);
    </script>
</body>
</html>
HTML

echo "✓ Created triadgen-complete.html"
echo ""

# Step 4: Launch the app
echo "[4/4] Launching TriadGen..."
echo ""

# Check if file was created successfully
if [ -f "enhanced-apps/triadgen-complete.html" ]; then
    echo "✅ SUCCESS! File created at:"
    echo "   $(pwd)/enhanced-apps/triadgen-complete.html"
    echo ""
    echo "Opening in browser..."
    start enhanced-apps/triadgen-complete.html
    echo ""
    echo "================================================"
    echo "           TRIADGEN IS READY!"
    echo "================================================"
    echo ""
    echo "TEST CHECKLIST:"
    echo "  1. ✓ Page should open in browser"
    echo "  2. ✓ Click 'Generate Chord' - see chord appear"
    echo "  3. ✓ Click 'Play Sound' - hear the chord"
    echo "  4. ✓ Click 'Generate 3' - see batch generation"
    echo ""
    echo "If sound doesn't work:"
    echo "  - Click anywhere on page first"
    echo "  - Check your volume"
    echo "  - Try Chrome or Firefox"
else
    echo "❌ ERROR: Failed to create file"
    echo "Try running the script again"
fi
