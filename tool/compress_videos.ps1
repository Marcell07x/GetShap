# Compresses the exercise videos for the server.
#
# Every video in video_sources/ that is not in server/videos/ yet is written
# there: the same picture size and frame rate, no sound (the app plays them
# muted), and a fraction of the bitrate. A video that is already in
# server/videos/ is left alone: what is on the server never changes, and a
# re-shot video gets a new name (see lib/workout/exercises.dart).
#
# server/ is what goes up into the website's media folder, as it is.
#
# Needs ffmpeg:  winget install --id Gyan.FFmpeg -e
# Run:           powershell -File tool\compress_videos.ps1

$ErrorActionPreference = 'Stop'

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    throw 'ffmpeg is not on the PATH. Install it (see the top of this file) and open a new terminal.'
}

$root = Split-Path $PSScriptRoot -Parent
$sources = Join-Path $root 'video_sources'
$target = Join-Path $root 'server\videos'
New-Item -ItemType Directory -Force $target | Out-Null

foreach ($source in Get-ChildItem (Join-Path $sources '*.mp4')) {
    $compressed = Join-Path $target $source.Name
    if (Test-Path $compressed) {
        continue
    }

    # -crf is the quality: lower is sharper and bigger. H.264 High at level 3.1
    # is what the original videos are, so every phone that played those plays
    # these.
    ffmpeg -v error -i $source.FullName -an -c:v libx264 -preset slow -crf 26 `
        -profile:v high -level:v 3.1 -pix_fmt yuv420p -movflags +faststart $compressed
    if ($LASTEXITCODE -ne 0) {
        throw "ffmpeg failed on $($source.Name)"
    }

    '{0}: {1:N0} KB -> {2:N0} KB' -f $source.Name, ($source.Length / 1KB), ((Get-Item $compressed).Length / 1KB)
}
