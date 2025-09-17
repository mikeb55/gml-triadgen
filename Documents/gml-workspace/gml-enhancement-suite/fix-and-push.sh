#!/bin/bash
# ALWAYS SET DIRECTORY FIRST
cd /c/Users/mike/Documents/gml-workspace/gml-enhancement-suite

echo "================================"
echo "    FIXING GIT & SAVING"
echo "================================"
echo ""

# Fix the lock issue
echo "Removing git lock file..."
rm -f .git/index.lock
echo "✓ Lock file removed"
echo ""

# Check status
echo "Current status:"
git status --short
echo ""

# Add all files
echo "Adding files..."
git add .
echo "✓ Files added"
echo ""

# Commit with message
echo "Creating commit..."
git commit -m "Add TriadGen with sound, templates, and all features"
echo ""

# Push to GitHub
echo "Pushing to GitHub..."
git push origin main

echo ""
echo "================================"
echo "    ✅ FIXED & SAVED!"
echo "================================"
echo "Your code is now on GitHub!"
echo "View at: https://github.com/mikeb55/-gml-enhancement-suite"
