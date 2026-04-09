# AI Gym Mentor Build Script
# Run this to regenerate all Drift and Riverpod code and resolve analyzer issues.

$flutterPath = "flutter" # Change this to the absolute path if flutter is not in your PATH

# Check if flutter is available
if (-not (Get-Command $flutterPath -ErrorAction SilentlyContinue)) {
    Write-Host "Error: 'flutter' command not found. Please ensure Flutter is installed and in your PATH, or update the `$flutterPath` variable in this script." -ForegroundColor Red
    exit 1
}

Write-Host "--- Cleaning Build ---" -ForegroundColor Cyan
& $flutterPath clean

Write-Host "--- Fetching Dependencies ---" -ForegroundColor Cyan
& $flutterPath pub get

Write-Host "--- Generating Code (Drift & Riverpod) ---" -ForegroundColor Cyan
& $flutterPath pub run build_runner build --delete-conflicting-outputs

Write-Host "--- Done ---" -ForegroundColor Green
