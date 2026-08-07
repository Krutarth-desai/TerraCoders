# GreenDrop

GreenDrop remains an HTML, CSS and vanilla JavaScript application, packaged in a minimal Android WebView shell. No React, Flutter or framework migration is involved.

## Product source

- `www/index.html` — app document and font loading
- `www/styles.css` — responsive visual system, light/dark themes, onboarding, motion and mobile navigation
- `www/app.js` — the original donation flows plus the premium experience layer

## Android shell

The Android wrapper is under `app/`. Gradle packages the same files from `www/` as Android assets, so there is only one source of truth.

Open the project in Android Studio (JDK 17, Android SDK 36) and use **Build → Generate App Bundles or APKs**. The first Gradle build downloads the Android Gradle Plugin if it is not already cached locally.

Equivalent command line build:

```powershell
gradle :app:assembleRelease
```

For a fully local build using only Android SDK build tools, run [`Build-Apk.ps1`](Build-Apk.ps1). It creates a signed debug APK at `build/GreenDrop-2.0.apk` and does not need Gradle or a network connection. If `javac` is not on your PATH, add `-JavaHome "C:\Program Files\Android\Android Studio\jbr"`.

The delivered `GreenDrop-2.0.apk` is signed with the same Android debug certificate as the supplied APK, so it can update that debug installation. For production distribution, replace the debug signing step with your own release keystore.
