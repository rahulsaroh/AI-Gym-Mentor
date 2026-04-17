# AI Gym Mentor Data-Safe Deployment Script
# This script ensures that the database is backed up and the app is updated without data loss.

$flutterPath = "C:\flutter\bin\flutter.bat"
$adbPath = "C:\Users\rahul\AppData\Local\Android\Sdk\platform-tools\adb.exe"
$javaPath = "D:\Apps\jdk17\jdk-17.0.2"
$packageName = "com.aigymmentor.app"
$dbName = "gym_log.sqlite"

# 1. Environment Setup
$env:JAVA_HOME = $javaPath
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "build\backups"
if (!(Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir }

# 2. Check Device
Write-Host "--- Checking Device ---" -ForegroundColor Cyan
$devices = & $adbPath devices | Select-String -Pattern "\tdevice$"
if ($devices.Count -eq 0) {
    Write-Host "Error: No device connected via ADB." -ForegroundColor Red
    exit 1
}
$deviceId = $devices[0].ToString().Split("`t")[0].Trim()
Write-Host "Target Device: $deviceId" -ForegroundColor Green

# 3. Backup Database
Write-Host "--- Backing Up Database ---" -ForegroundColor Cyan
$backupFile = "$backupDir\gym_log_$timestamp.sqlite"
& $adbPath -s $deviceId exec-out run-as $packageName cat app_flutter/$dbName > $backupFile
if (Test-Path $backupFile) {
    Write-Host "Backup saved to: $backupFile" -ForegroundColor Green
} else {
    Write-Host "Warning: Backup failed or app not installed yet." -ForegroundColor Yellow
}

# 4. Build APK
Write-Host "--- Building APK (assembleDebug) ---" -ForegroundColor Cyan
Push-Location android
.\gradlew.bat assembleDebug
Pop-Location

# 5. Safe Install
Write-Host "--- Performing Safe Installation (Update) ---" -ForegroundColor Cyan
$apkPath = "build\app\outputs\flutter-apk\app-debug.apk"
& $adbPath -s $deviceId install -r $apkPath

if ($LASTEXITCODE -eq 0) {
    Write-Host "--- Deployment Successful (Data Preserved) ---" -ForegroundColor Green
    & $adbPath -s $deviceId shell am start -n $packageName/$packageName.MainActivity
} else {
    Write-Host "--- Deployment Failed ---" -ForegroundColor Red
}
