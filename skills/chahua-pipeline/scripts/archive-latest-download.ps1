param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('collage','video')]
    [string]$Kind,

    [Parameter(Mandatory=$true)]
    [string]$SceneKeyword,

    [datetime]$Since = (Get-Date).AddMinutes(-20),

    [string]$DownloadsDir = "$env:USERPROFILE\Downloads"
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $DownloadsDir)) {
    throw "Downloads folder not found: $DownloadsDir"
}

$today = Get-Date -Format 'yyyyMMdd'
$safeKeyword = ($SceneKeyword -replace '[^a-zA-Z0-9_-]', '-') -replace '-+', '-'
$safeKeyword = $safeKeyword.Trim('-')
if ([string]::IsNullOrWhiteSpace($safeKeyword)) { $safeKeyword = 'scene' }

if ($Kind -eq 'collage') {
    $extensions = @('.png','.jpg','.jpeg','.webp')
    $destinationDir = 'D:\picture-output'
    $suffix = 'collage'
} else {
    $extensions = @('.mp4')
    $destinationDir = 'D:\picture-output\video'
    $suffix = 'making'
}

if (-not (Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
}

$candidate = Get-ChildItem -Path $DownloadsDir -File |
    Where-Object { $extensions -contains $_.Extension.ToLowerInvariant() -and $_.LastWriteTime -ge $Since } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $candidate) {
    throw "No recent $Kind download found after $Since in $DownloadsDir"
}

$extension = $candidate.Extension.ToLowerInvariant()
$baseName = "${today}_${safeKeyword}_${suffix}"
$destination = Join-Path $destinationDir ($baseName + $extension)
$counter = 2
while (Test-Path $destination) {
    $destination = Join-Path $destinationDir ("${baseName}_" + ('{0:D2}' -f $counter) + $extension)
    $counter++
}

Move-Item -LiteralPath $candidate.FullName -Destination $destination

$result = Get-Item -LiteralPath $destination
Write-Output $result.FullName
