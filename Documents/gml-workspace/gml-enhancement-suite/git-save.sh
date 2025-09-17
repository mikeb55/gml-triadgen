#!/bin/bash
# ALWAYS SET DIRECTORY FIRST
cd /c/Users/mike/Documents/gml-workspace/gml-enhancement-suite

echo "================================"
echo "    SAVING TO GITHUB"
echo "================================"
echo ""

# Show what will be saved
echo "Files to save:"
git status --short
echo ""

# Add everything
git add .

# Create commit with timestamp
COMMIT_MSG="Update GML Enhancement Suite - $(date '+%Y-%m-%d %H:%M')"
git commit -m "$COMMIT_MSG"

# Push to GitHub
echo ""
echo "Pushing to GitHub..."
git push origin main

echo ""
echo "================================"
echo "    ✅ SAVED TO GITHUB!"
echo "================================"
echo ""
echo "Your code is now backed up online!"
echo "View at: https://github.com/mikeb55/-gml-enhancement-suite"
