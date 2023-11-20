
param (
    [string]$jsonFilePath = "C:\Users\Slaviboy\Desktop\configs.json",
    [string]$outputDirectory = "C:\Users\Slaviboy\Desktop\dpm"
)

# Read the JSON file content
$jsonContent = Get-Content -Raw -Path $jsonFilePath | ConvertFrom-Json

# Function to download a file
function Download-File ($url, $outputPath) {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $outputPath)
}

New-Item -ItemType Directory -Force -Path "$outputDirectory\cover_icons"
New-Item -ItemType Directory -Force -Path "$outputDirectory\covers"
New-Item -ItemType Directory -Force -Path "$outputDirectory\audio_previews"

# Loop through categories
foreach ($category in $jsonContent.categories) {
    # Loop through presets
    foreach ($preset in $jsonContent.presets.PSObject.Properties) {
        $presetData = $preset.Value
        $name = $presetData.name.ToLower() -replace '\s', '_'

        # Check if icon exists and download it
        if ($presetData.icon) {
            $outputFileName = Join-Path $outputDirectory "\cover_icons\$name.jpg"
            Download-File -url $presetData.icon -outputPath $outputFileName
            Write-Host "Downloaded: $($presetData.icon) to $($outputFileName)"
        }

        # Check if imagePreview1 exists and download it
        if ($presetData.imagePreview1) {
            $outputFileName = Join-Path $outputDirectory "\covers\$name.jpg"
            Download-File -url $presetData.imagePreview1 -outputPath $outputFileName
            Write-Host "Downloaded: $($presetData.imagePreview1) to $($outputFileName)"
        }

        # Check if audioPreview1URL exists and download it
        if ($presetData.audioPreview1URL) {
            $outputFileName = Join-Path $outputDirectory "\audio_previews\$name.mp3"
            Download-File -url $presetData.audioPreview1URL -outputPath $outputFileName
            Write-Host "Downloaded: $($presetData.audioPreview1URL) to $($outputFileName)"
        }

    }
}

Write-Host "Download process completed."