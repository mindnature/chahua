$ErrorActionPreference = 'Stop'

$inputDir = 'D:\picture'
$outputDir = 'D:\picture-output'
$videoDir = 'D:\picture-output\video'
$stateFile = 'D:\picture-output\.chahua-state.json'

@($inputDir, $outputDir, $videoDir) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
}

if (-not (Test-Path $stateFile)) {
    $state = [ordered]@{
        run_id = ''
        date = ''
        stage = 'select'
        speed_profile = 'FAST'
        max_items = 1
        video_stop_after_download = $true
        auto_retry_quality = $false
        source_image = ''
        source_url = ''
        search_directions = @()
        selection_score = [ordered]@{
            scene_fit = 0
            craft_reconstructability = 0
            narrative_mood = 0
            color_identity = 0
            focus_whitespace = 0
            quality_downloadability = 0
            total = 0
        }
        poster_final_image = ''
        xiaohongshu_text_file = ''
        video_input_image = ''
        video_downloaded_file = ''
        last_error = ''
    }
    $state | ConvertTo-Json -Depth 8 | Set-Content -Path $stateFile -Encoding UTF8
}

Write-Output "READY"
Write-Output "PROFILE=FAST"
Write-Output "INPUT=$inputDir"
Write-Output "OUTPUT=$outputDir"
Write-Output "VIDEO=$videoDir"
Write-Output "STATE=$stateFile"
