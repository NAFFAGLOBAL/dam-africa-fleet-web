#!/bin/bash
# Quick Start - Push to GitHub and Begin Development

echo "🚀 DAM Africa Fleet Web - Quick Start"
echo "======================================"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Run this from /root/.openclaw/workspace/DAM-Africa/"
    exit 1
fi

echo "📁 Current location: $(pwd)"
echo ""

# Check if remote exists
if git remote | grep -q origin; then
    echo "✅ Git remote 'origin' already configured"
    REMOTE=$(git remote get-url origin)
    echo "   Remote: $REMOTE"
else
    echo "⚠️  No GitHub remote configured yet"
    echo ""
    echo "📝 Next steps:"
    echo "1. Create new repo: https://github.com/new"
    echo "2. Name it: dam-africa-fleet-web"
    echo "3. Run this command:"
    echo ""
    echo "   git remote add origin https://github.com/YOUR-USERNAME/dam-africa-fleet-web.git"
    echo ""
    exit 1
fi

# Check if we need to push
if git status | grep -q "Your branch is ahead"; then
    echo ""
    echo "📤 Ready to push to GitHub..."
    echo ""
    read -p "Push now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push -u origin main
        echo ""
        echo "✅ Pushed to GitHub!"
        echo ""
        echo "🎯 Next: Tell Claude Code to:"
        echo "   1. Clone: git clone $REMOTE"
        echo "   2. Read: README.md and mobile-app-specs.md"
        echo "   3. Build: Phase 1 Flutter web app"
    fi
else
    echo "✅ Already pushed to GitHub"
    echo ""
    echo "📊 Repository status:"
    git log -1 --oneline
fi

echo ""
echo "📚 Documentation available:"
echo "   - README.md - Overview & quick start"
echo "   - mobile-app-specs.md - Complete technical specs"
echo "   - docs/CUSTOMER_API_GUIDE.md - Send to customer"
echo "   - PROJECT_STATUS.md - Current status"
echo ""
echo "🔥 Ready to build!"
