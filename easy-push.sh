#!/bin/bash

echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                    EDUSHARE - EASY GITHUB PUSH                             ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Check if we're in the right directory
if [ ! -f "learn.sh" ]; then
    echo "Error: Not in the learning-system directory"
    echo "Please run: cd /tmp/learning-system"
    exit 1
fi

# Check git status
echo "Current git status:"
git status
echo ""

# Show what will be pushed
echo "Commits to be pushed:"
git log origin/main..HEAD --oneline 2>/dev/null || git log --oneline
echo ""

# Confirm
echo "Ready to push to: https://github.com/Dylanv1324/vase-repo.git"
echo ""
echo "You will need your GitHub Personal Access Token"
echo "    Get it from: https://github.com/settings/tokens"
echo ""
read -p "Continue? (y/n): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Push cancelled"
    exit 0
fi

echo ""
echo "Pushing to GitHub..."
echo "   When prompted for password, paste your Personal Access Token"
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║                        PUSH SUCCESSFUL!                              ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Your EduShare system is now on GitHub!"
    echo ""
    echo "View it at: https://github.com/Dylanv1324/vase-repo"
    echo ""
    echo "Others can clone it with:"
    echo "  git clone https://github.com/Dylanv1324/vase-repo.git"
    echo ""
else
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║                          PUSH FAILED                                 ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Common issues:"
    echo "  1. Wrong credentials - Make sure you're using a Personal Access Token"
    echo "  2. Token doesn't have 'repo' permissions"
    echo "  3. Repository doesn't exist or you don't have access"
    echo ""
    echo "See PUSH_TO_GITHUB.txt for detailed help"
    exit 1
fi
