# Push to GitHub - Instructions for Mamadou

## Quick Steps

### 1. Create New GitHub Repo
Go to: https://github.com/new

**Settings:**
- Repository name: `dam-africa-fleet-web`
- Description: "DAM Africa Fleet Management - Web & Mobile App (Flutter)"
- Visibility: **Private** (or Public if you want)
- **Do NOT** initialize with README (we already have one)

Click "Create repository"

---

### 2. Copy This and Run on VPS

GitHub will show you commands. Use these instead:

```bash
cd /root/.openclaw/workspace/DAM-Africa

# Configure git (if not already done)
git config user.name "Mamadou Samba Diallo"
git config user.email "your-email@example.com"

# Check current status
git status

# Add remote (replace USERNAME with your GitHub username)
git remote add origin https://github.com/USERNAME/dam-africa-fleet-web.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

---

### 3. If You Need Personal Access Token

If GitHub asks for password, use a **Personal Access Token**:

**Get token:**
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes: `repo` (full control)
4. Click "Generate token"
5. **COPY IT** (you won't see it again!)

**Use it as password:**
```bash
Username: your-github-username
Password: ghp_xxxxxxxxxxxxxxxxxxxx  (paste token here)
```

---

### 4. Share Repo Link with Claude Code

Once pushed, give Claude Code this command:

```bash
cd ~
git clone https://github.com/USERNAME/dam-africa-fleet-web.git
cd dam-africa-fleet-web
```

Then tell Claude Code:

> "Repo cloned. Read README.md and mobile-app-specs.md. 
> Build Phase 1 (Flutter web app with auth + dashboards) in fleet-web/ directory. 
> Follow all specs exactly. Use mock data (no backend needed yet)."

---

## Alternative: I Can Do It If You Give Me Token

If you want me (Omar) to push it:

1. **Create the GitHub repo** (dam-africa-fleet-web)
2. **Generate a token** (steps above)
3. **Send me:**
   - Your GitHub username
   - The personal access token
   - Repo name (if different)

I'll push everything immediately.

---

## What's Being Pushed

```
DAM-Africa/
├── README.md (setup instructions)
├── mobile-app-specs.md (15+ pages of specs)
├── SETUP.md (Flutter installation)
├── PROJECT_STATUS.md (current status)
├── PUSH_TO_GITHUB.md (this file)
├── docs/
│   ├── CUSTOMER_API_GUIDE.md (send to customer)
│   └── WEB_FIRST_STRATEGY.md (deployment plan)
└── .git/ (git history)
```

**NOT pushing yet:**
- `fleet-web/` folder (Claude Code will create this)

---

## Once Pushed - Next Steps

1. Claude Code clones repo
2. Claude Code builds Flutter app in `fleet-web/`
3. Claude Code commits and pushes changes
4. You test in browser
5. We deploy to Vercel for customer

---

Ready when you are! 🚀
