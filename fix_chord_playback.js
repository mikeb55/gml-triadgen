// Fix the playback to play actual CHORDS not arpeggios
async function playTriads() {
    if (currentTriads.length === 0) {
        updateStatus('⚠️ Generate triads first!', '#FF9800');
        return;
    }
    
    updateStatus('🔊 Playing CHORDS...', '#2196F3');
    isPlaying = true;
    
    await Tone.start();
    
    // Dispose old synth
    if (window.synth) window.synth.dispose();
    
    // Create PolySynth for chords
    window.synth = new Tone.PolySynth(Tone.Synth, {
        maxPolyphony: 12,  // Allow multiple notes
        envelope: {
            attack: 0.02,
            decay: 0.2,
            sustain: 0.5,
            release: 0.8
        },
        oscillator: {
            type: "triangle"  // Softer sound for chords
        }
    }).toDestination();
    
    // Set volume
    window.synth.volume.value = -10;
    
    // Play each triad as a TRUE CHORD
    const now = Tone.now();
    
    currentTriads.forEach((triad, index) => {
        const startTime = now + (index * 0.8);  // Space between chords
        
        // Convert all notes to frequencies
        const frequencies = triad.notes.map(note => 
            Tone.Frequency(note, "midi").toFrequency()
        );
        
        // Play ALL notes of the chord SIMULTANEOUSLY
        window.synth.triggerAttackRelease(
            frequencies,  // All notes at once
            "4n",        // Duration
            startTime    // When to play
        );
        
        // Visual feedback (optional)
        setTimeout(() => {
            console.log(`Playing chord ${index + 1}: ${triad.notes.map(n => noteToName(n)).join('+')}`);
        }, index * 800);
    });
    
    // Update status when done
    setTimeout(() => {
        if (isPlaying) {
            updateStatus('✅ Chord playback complete');
            isPlaying = false;
        }
    }, currentTriads.length * 800);
}

// Alternative: Play as sustained chord progression
function playAsSustainedChords() {
    if (currentTriads.length === 0) return;
    
    Tone.start().then(() => {
        const piano = new Tone.PolySynth(Tone.Synth).toDestination();
        
        // Play all triads simultaneously for a wall of sound
        currentTriads.forEach((triad, i) => {
            piano.triggerAttackRelease(
                triad.notes.map(n => Tone.Frequency(n, "midi")),
                "2n",
                `+${i * 0.5}`
            );
        });
    });
}

// Make it global
window.playTriads = playTriads;
window.playAsSustainedChords = playAsSustainedChords;

console.log('✅ Chord playback fixed! Triads will now play as proper chords.');
