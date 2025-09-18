// BULLETPROOF Export that creates ACTUAL CHORDS

class BulletproofChordExport {
    
    // Export to MIDI with proper chords
    exportToMIDI(triads) {
        const bytes = [];
        
        // MIDI Header
        bytes.push(...[0x4D, 0x54, 0x68, 0x64]); // "MThd"
        bytes.push(...[0x00, 0x00, 0x00, 0x06]); // Header length
        bytes.push(...[0x00, 0x01]); // Format 1
        bytes.push(...[0x00, 0x01]); // 1 track
        bytes.push(...[0x01, 0xE0]); // 480 ticks/quarter
        
        // Track header
        bytes.push(...[0x4D, 0x54, 0x72, 0x6B]); // "MTrk"
        
        // Build track data
        const trackData = [];
        
        // Tempo
        trackData.push(...[0x00, 0xFF, 0x51, 0x03, 0x07, 0xA1, 0x20]); // 120 BPM
        
        // Process each triad as a CHORD
        let currentTime = 0;
        triads.forEach(triad => {
            // ALL notes of the chord start at SAME time (delta = 0)
            triad.notes.forEach((note, index) => {
                // First note has the actual delta time
                // Other notes have delta = 0 (simultaneous)
                const deltaTime = index === 0 ? currentTime : 0;
                
                // Note ON
                trackData.push(deltaTime);
                trackData.push(0x90); // Note ON, channel 0
                trackData.push(note);  // Pitch
                trackData.push(80);    // Velocity
            });
            
            // After 480 ticks (one beat), turn all notes OFF
            triad.notes.forEach((note, index) => {
                const deltaTime = index === 0 ? 480 : 0;
                
                // Note OFF
                trackData.push(deltaTime);
                trackData.push(0x80); // Note OFF
                trackData.push(note);
                trackData.push(0);
            });
            
            currentTime = 0; // Reset for next chord
        });
        
        // End of track
        trackData.push(...[0x00, 0xFF, 0x2F, 0x00]);
        
        // Add track length
        const trackLength = trackData.length;
        bytes.push((trackLength >> 24) & 0xFF);
        bytes.push((trackLength >> 16) & 0xFF);
        bytes.push((trackLength >> 8) & 0xFF);
        bytes.push(trackLength & 0xFF);
        bytes.push(...trackData);
        
        return new Uint8Array(bytes);
    }
    
    // Export to MusicXML with proper chords
    exportToMusicXML(triads) {
        let xml = `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 3.1 Partwise//EN" 
  "http://www.musicxml.org/dtds/partwise.dtd">
<score-partwise version="3.1">
  <work><work-title>Triads (Chords)</work-title></work>
  <part-list>
    <score-part id="P1">
      <part-name>Piano</part-name>
    </score-part>
  </part-list>
  <part id="P1">`;
        
        triads.forEach((triad, measureNum) => {
            xml += `
    <measure number="${measureNum + 1}">`;
            
            if (measureNum === 0) {
                xml += `
      <attributes>
        <divisions>1</divisions>
        <key><fifths>0</fifths></key>
        <time><beats>4</beats><beat-type>4</beat-type></time>
        <clef><sign>G</sign><line>2</line></clef>
      </attributes>`;
            }
            
            // Add all notes as a CHORD (same duration, with chord tag)
            triad.notes.forEach((midiNote, index) => {
                const noteName = this.midiToNote(midiNote);
                
                xml += `
      <note>`;
                
                // CRITICAL: Add chord tag for notes 2+ in the chord
                if (index > 0) {
                    xml += `
        <chord/>`; // This makes it simultaneous with previous note!
                }
                
                xml += `
        <pitch>
          <step>${noteName.step}</step>
          <octave>${noteName.octave}</octave>
        </pitch>
        <duration>1</duration>
        <type>quarter</type>
      </note>`;
            });
            
            // Add rest to fill measure
            xml += `
      <note>
        <rest/>
        <duration>3</duration>
        <type>half</type>
        <dot/>
      </note>`;
            
            xml += `
    </measure>`;
        });
        
        xml += `
  </part>
</score-partwise>`;
        
        return xml;
    }
    
    midiToNote(midi) {
        const noteNames = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
        const octave = Math.floor(midi / 12) - 1;
        const noteIndex = midi % 12;
        let step = noteNames[noteIndex].replace('#', '');
        
        return {
            step: step,
            octave: octave,
            alter: noteNames[noteIndex].includes('#') ? 1 : 0
        };
    }
    
    download(filename, data) {
        const blob = data instanceof Uint8Array 
            ? new Blob([data], { type: 'audio/midi' })
            : new Blob([data], { type: 'application/xml' });
        
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        a.click();
        URL.revokeObjectURL(url);
    }
}

// Override export functions
window.bulletproofExport = new BulletproofChordExport();

window.exportMIDI = function() {
    if (!currentTriads || currentTriads.length === 0) {
        alert('Generate triads first!');
        return;
    }
    
    const midiData = window.bulletproofExport.exportToMIDI(currentTriads);
    window.bulletproofExport.download('triads_CHORDS.mid', midiData);
    updateStatus('✅ MIDI with CHORDS exported!');
};

window.exportMusicXML = function() {
    if (!currentTriads || currentTriads.length === 0) {
        alert('Generate triads first!');
        return;
    }
    
    const xml = window.bulletproofExport.exportToMusicXML(currentTriads);
    window.bulletproofExport.download('triads_CHORDS.xml', xml);
    updateStatus('✅ MusicXML with CHORDS exported!');
};

console.log('✅ BULLETPROOF Export loaded - will create real CHORDS not arpeggios!');
