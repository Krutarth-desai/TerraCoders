param(
    [string]$AndroidSdk = $env:ANDROID_HOME,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$Keystore = (Join-Path $env:USERPROFILE '.android\debug.keystore'),
    [string]$KeyAlias = 'androiddebugkey',
    [string]$StorePassword = 'android',
    [string]$KeyPassword = 'android'
)

$ErrorActionPreference = 'Stop'

if (-not $AndroidSdk -or -not (Test-Path -LiteralPath $AndroidSdk)) {
    throw 'Set ANDROID_HOME or pass -AndroidSdk with an installed Android SDK path.'
}
if (-not (Test-Path -LiteralPath $Keystore)) {
    throw 'Pass a signing keystore with -Keystore. The default expects the Android debug keystore.'
}

$projectRoot = Split-Path -Parent $PSCommandPath
$buildRoot = Join-Path $projectRoot 'build\manual'
$apkTools = Join-Path $AndroidSdk 'build-tools\36.0.0'
$androidJar = Join-Path $AndroidSdk 'platforms\android-36\android.jar'
$manifest = Join-Path $projectRoot 'app\src\main\AndroidManifest.xml'
$activity = Join-Path $projectRoot 'app\src\main\java\com\greendrop\app\MainActivity.java'
$classes = Join-Path $buildRoot 'classes'
$dexDirectory = Join-Path $buildRoot 'dex'
$baseApk = Join-Path $buildRoot 'GreenDrop-unsigned.apk'
$alignedApk = Join-Path $buildRoot 'GreenDrop-aligned.apk'
$outputApk = Join-Path $projectRoot 'build\GreenDrop-2.0.apk'

foreach ($directory in @($buildRoot, $classes, $dexDirectory, (Split-Path -Parent $outputApk))) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

if ($JavaHome -and (Test-Path -LiteralPath (Join-Path $JavaHome 'bin\javac.exe'))) {
    $javac = Join-Path $JavaHome 'bin\javac.exe'
} else {
    $javac = (Get-Command javac -ErrorAction Stop).Source
}
& $javac -source 8 -target 8 -bootclasspath $androidJar -d $classes $activity
& (Join-Path $apkTools 'd8.bat') --min-api 24 --lib $androidJar --output $dexDirectory (Join-Path $classes 'com\greendrop\app\MainActivity.class')
& (Join-Path $apkTools 'aapt2.exe') link -o $baseApk -I $androidJar --manifest $manifest --min-sdk-version 24 --target-sdk-version 36 --version-code 2 --version-name 2.0.0

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [System.IO.Compression.ZipFile]::Open($baseApk, [System.IO.Compression.ZipArchiveMode]::Update)
try {
    $files = @{
        'classes.dex' = (Join-Path $dexDirectory 'classes.dex')
        'assets/index.html' = (Join-Path $projectRoot 'www\index.html')
        'assets/styles.css' = (Join-Path $projectRoot 'www\styles.css')
        'assets/app.js' = (Join-Path $projectRoot 'www\app.js')
    }
    foreach ($entryName in $files.Keys) {
        $oldEntry = $archive.GetEntry($entryName)
        if ($null -ne $oldEntry) { $oldEntry.Delete() }
        $newEntry = $archive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        $target = $newEntry.Open()
        $source = [System.IO.File]::OpenRead($files[$entryName])
        try { $source.CopyTo($target) } finally { $source.Dispose(); $target.Dispose() }
    }
} finally {
    $archive.Dispose()
}

& (Join-Path $apkTools 'zipalign.exe') -f 4 $baseApk $alignedApk
& (Join-Path $apkTools 'apksigner.bat') sign --ks $Keystore --ks-key-alias $KeyAlias --ks-pass "pass:$StorePassword" --key-pass "pass:$KeyPassword" --out $outputApk $alignedApk
& (Join-Path $apkTools 'apksigner.bat') verify --verbose $outputApk

Write-Output "Built and signed: $outputApk"
