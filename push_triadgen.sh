#!/bin/bash

echo "📦 PUSHING TRIADGEN UPDATES"
echo "==========================="
echo ""

# Show what files we have
echo "📄 TriadGen files:"
ls -la *.html *.js 2>/dev/null
echo ""

# Check git status
echo "📊 Git status:"
git status --short
echo ""

# Add all changes
git add -A

# Commit with specific message
git commit -m "TriadGen: Template System + enhanced version + sound fixes

✅ Added Template System integration
✅ Created triadgen-enhanced.html (standardized)
✅ Fixed generate functions (no more fake errors)
✅ Added VoiceLeading.js support
✅ Integrated universal_generator.js
✅ BULLETPROOF-9x3 protocol applied

Files updated:
- triadgen.html (original)
- triadgen_fixed.html (debugging version)
- triadgen-enhanced.html (final enhanced version)
- Added Template dropdown
- Working generation functions"

# Try to push
echo ""
echo "🚀 Pushing to GitHub..."

if git push origin main 2>/dev/null; then
    echo "✅ TriadGen pushed successfully!"
elif git push origin master 2>/dev/null; then
    echo "✅ TriadGen pushed to master branch!"
elif git push -u origin main 2>/dev/null; then
    echo "✅ TriadGen pushed (new tracking)!"
else
    echo "⚠️  Could not push automatically."
    echo "   Run manually: git push origin main"
    echo ""
    echo "📝 If this is a new repo, you may need to:"
    echo "   1. Create repo on GitHub: https://github.com/mikeb55/triadgen"
    echo "   2. git remote add origin https://github.com/mikeb55/triadgen.git"
    echo "   3. git push -u origin main"
fi

echo ""
echo "💾 TriadGen changes committed locally!"
