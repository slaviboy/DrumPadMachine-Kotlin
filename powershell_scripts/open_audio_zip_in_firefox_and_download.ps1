# This script will open all audio *zip archive links in Firefox browser, which will download them in Download folder
$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"

for ($i = 0; $i -le 500; $i++) {
    $url = "https://cloudflare-content-dpm.easybrain.com/shared/files/dpm/presets/id/$i.zip"

    try {
        # Attempt to open URL in Firefox
        Start-Process $firefoxPath -ArgumentList $url -ErrorAction Stop
        Write-Host "Opened in Firefox: $url"
    } catch {
        Write-Host "File not found or error opening URL: $url"
    }
}