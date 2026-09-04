# EduTrack TWA (Trusted Web Activity) APK Builder

This directory contains the configuration to build a native Android APK
that wraps the EduTrack PWA using Google's Bubblewrap CLI.

## Prerequisites

1. **Node.js** (v14+)
2. **Java JDK** (v11+)

## Build Steps

```bash
# 1. Install Bubblewrap globally
npm install -g @nicedayto/nicedayto-cli

# 2. Initialize the TWA project from the manifest
cd twa
npx @nicedayto/nicedayto-cli init --manifest=https://edutrack-9srw.onrender.com/static/manifest.json

# 3. Build the APK
npx @nicedayto/nicedayto-cli build

# 4. The APK will be generated at:
#    app/build/outputs/apk/release/app-release-signed.apk
```

## Alternative: PWABuilder (No Install Required)

1. Go to [PWABuilder.com](https://www.pwabuilder.com/)
2. Enter your URL: `https://edutrack-9srw.onrender.com`
3. Click "Package for stores" → Android
4. Download the generated APK

## What This APK Does

- Opens EduTrack in a full-screen Chrome Custom Tab (no address bar)
- Status bar matches the app theme color (#3B6582 light / #0F172A dark)
- Automatically updates content from the live Render site
- No app store update needed — deploy to GitHub → Render auto-deploys → app updates
