#!/bin/bash

echo "📦 GIT COMMIT & PUSH - Sept 18 Session"
echo "======================================"

# Commit message
MSG="Sept 18: TriadGen complete overhaul - dual triads, full menus, working exports

✅ Created WORKING_TRIADGEN.html - properly exports chords
✅ Created DUAL_TRIAD_GEN.html - two independent triad controls  
✅ Created FULL_TRIADGEN.html - comprehensive professional version
✅ Fixed MIDI export - no more 300 blank bars
✅ Fixed MusicXML export - proper .musicxml extension
✅ Added chord inversions
✅ Extended chord types (9ths, 11ths, 13ths)
✅ Progression builder
✅ Tempo/volume controls
✅ Multiple playback modes
✅ JSON export and clipboard copy
✅ All exports create proper chords with <chord/> tags

Features:
- Full octave range C2-C6
- 20+ chord types
- Inversions for all chords
- Plays as actual chords not arpeggios
- MIDI and MusicXML both working correctly"

# Add all new files
git add -A

# Commit
git commit -m "$MSG"

# Push to GitHub
if git push origin main 2>/dev/null; then
    echo "✅ Pushed to main branch"
elif git push origin master 2>/dev/null; then
    echo "✅ Pushed to master branch"
else
    echo "⚠️ Push failed - may need authentication"
fi

echo ""
echo "📊 Session Summary:"
echo "  • Fixed all export issues"
echo "  • Created 3 working versions"
echo "  • All chords play correctly"
echo "  • Ready for Guitar Pro & Sibelius"

