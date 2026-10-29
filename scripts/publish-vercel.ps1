[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$Scope,
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$ProjectName = 'groep7-toetsen',
    [ValidatePattern('^[a-z0-9][a-z0-9-]*\.html$')]
    [string]$QuizPage = 'zeeen-en-gebergten.html'
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
Push-Location $root
try {
    $changes = & git status --porcelain
    if ($LASTEXITCODE -ne 0) { throw 'Git-status kon niet worden gelezen.' }
    if ($changes) { throw 'Commit eerst alle toetswijzigingen voordat je publiceert.' }

    $tracked = @(& git ls-files)
    if ($LASTEXITCODE -ne 0) { throw 'De Git-bestandslijst kon niet worden gelezen.' }
    # Alleen publieke webbestanden, nooit skills, scripts, Git-data of credentials.
    $webFiles = @($tracked | Where-Object {
        $_ -match '^[^/.][^/]*\.(html|js|css)$' -or
        $_ -match '^assets/[^.][^\\]*\.(png|jpg|jpeg|webp|gif|svg|ico|woff2|mp3|mp4)$'
    })
    if ($QuizPage -notin $webFiles) { throw "Toetspagina niet gevonden in Git: $QuizPage" }
    if ('index.html' -notin $webFiles) { throw 'index.html ontbreekt in Git.' }

    & npx --yes vercel@65.1.0 link --yes --project $ProjectName --scope $Scope
    if ($LASTEXITCODE -ne 0) { throw 'Koppelen aan Vercel is mislukt.' }

    $output = Join-Path $root '.vercel\output'
    if (Test-Path -LiteralPath $output) {
        Remove-Item -LiteralPath $output -Recurse -Force
    }
    $static = Join-Path $output 'static'
    New-Item -ItemType Directory -Path $static -Force | Out-Null
    foreach ($file in $webFiles) {
        $relative = $file.Replace('/', '\')
        $destination = Join-Path $static $relative
        New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
        Copy-Item -LiteralPath (Join-Path $root $relative) -Destination $destination
    }
    '{"version":3}' | Set-Content -LiteralPath (Join-Path $output 'config.json') -Encoding utf8

    $result = @(& npx --yes vercel@65.1.0 deploy --prebuilt --prod --yes --scope $Scope)
    if ($LASTEXITCODE -ne 0) { throw 'Publiceren op Vercel is mislukt.' }
    $deployment = $result | Where-Object { $_ -match '^https://[a-z0-9.-]+\.vercel\.app/?$' } | Select-Object -Last 1
    if (-not $deployment) { throw 'Vercel heeft geen deployment-URL teruggegeven.' }

    $quizUrl = "$($deployment.TrimEnd('/'))/$QuizPage"
    $response = Invoke-WebRequest -Uri $quizUrl
    if ($response.StatusCode -ne 200 -or $response.Content -notmatch '<html') {
        throw "De gepubliceerde toets is niet bereikbaar: $quizUrl"
    }
    Write-Output "Deployment: $deployment"
    Write-Output "Toets: $quizUrl"
}
finally {
    Pop-Location
}
