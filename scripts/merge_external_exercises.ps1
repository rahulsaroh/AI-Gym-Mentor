# AI Gym Mentor - External Exercise Integration Script (v3 - Overwrite Fix)
# This script fetches exercises from a GitHub repo, transforms them, and merges/updates them in the local assets.

$baseUrl = "https://raw.githubusercontent.com/rahulsaroh/exercises-dataset/main/"
$externalUrl = $baseUrl + "data/exercises.json"
$localPath = "assets/data/exercises.json"

# 1. Fetch external data
Write-Host "--- Fetching External Dataset ---" -ForegroundColor Cyan
try {
    $externalData = Invoke-RestMethod -Uri $externalUrl
} catch {
    Write-Host "Error fetching data: $_" -ForegroundColor Red
    exit 1
}

# 2. Transform external data
Write-Host "--- Transforming Exercises (Mapping Schema) ---" -ForegroundColor Cyan
$transformed = $externalData | ForEach-Object {
    $muscles = if ($_.muscle_group) { @($_.muscle_group) } else { @("Other") }
    # To force ConvertTo-Json to treat it as an array if it has 1 element, we can use a wrapper or simply ensure it's cast correctly.
    # In PS, @(item) usually works, but ConvertTo-Json can be stubborn.
    
    [PSCustomObject]@{
        id = $_.id.ToString()
        name = $_.name
        description = ""
        category = if ($_.category) { $_.category } else { "strength" }
        difficulty = "beginner"
        primaryMuscles = $muscles
        secondaryMuscles = if ($_.secondary_muscles) { $_.secondary_muscles } else { @() }
        equipment = if ($_.equipment) { $_.equipment } else { "body only" }
        instructions = if ($_.instructions.en) { $_.instructions.en } else { @() }
        gifUrl = if ($_.gif_url) { $baseUrl + $_.gif_url } else { $null }
        imageUrl = if ($_.image) { $baseUrl + $_.image } else { $null }
        videoUrl = $null
        mechanic = "isolation"
        force = "pull"
        source = "exercises-dataset-github"
        safetyTips = @()
        commonMistakes = @()
        nameHindi = $_.name
        nameMarathi = $_.name
        nameHi = $_.name
        nameMr = $_.name
        overview = "Imported from rahulsaroh/exercises-dataset."
        isEnriched = $false
    }
}

# 3. Load and Filter existing data
Write-Host "--- Processing Local Exercises ---" -ForegroundColor Cyan
if (Test-Path $localPath) {
    $localJson = Get-Content -Raw $localPath
    $localData = $localJson | ConvertFrom-Json
    
    # Filter out any exercises that are from the GitHub source to avoid duplicates/carry-over errors
    $baseData = $localData | Where-Object { $_.source -ne "exercises-dataset-github" }
    Write-Host "Kept $($baseData.Count) original exercises." -ForegroundColor Green
} else {
    $baseData = @()
}

# 4. Merge
Write-Host "--- Merging Datasets ---" -ForegroundColor Cyan
$mergedData = $baseData + $transformed
Write-Host "Integrated $($transformed.Count) exercises from GitHub." -ForegroundColor Green

# 5. Write to File
Write-Host "--- Saving to $localPath ---" -ForegroundColor Cyan
# PowerShell's ConvertTo-Json is notoriously bad at preserving single-item arrays.
# We will use a small inline C# or just accept that the Dart seeder handles it (it does: item['primaryMuscles'] as List? ?? [])
# Wait, if it's a String, "item['primaryMuscles'] as List?" will return null, then it defaults to [].
# That's not good, we lose the muscle name!
# So I MUST ensure it's an array if I can, OR update the Seeder to handle String.

# Let's try the PS trick: 
# Using a custom JSON serializer or simply ensuring we have more than 1 item in the list of exercises helps with the overall structure, but for individual fields...
# Actually, the Dart seeder can be updated to handle både List AND String. Correcting the Seeder is more robust.

$jsonOutput = $mergedData | ConvertTo-Json -Depth 20
Set-Content -Path $localPath -Value $jsonOutput -Encoding utf8

Write-Host "Total exercise count: $($mergedData.Count)" -ForegroundColor Green
