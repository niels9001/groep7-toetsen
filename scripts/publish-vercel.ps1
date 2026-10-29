[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$Scope,
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$ProjectName = 'harlekijn-groep7-toetsen',
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
    if ($QuizPage -notin $tracked) { throw "Toetspagina niet gevonden in Git: $QuizPage" }

    & npx --yes vercel@65.1.0 link --yes --project $ProjectName --scope $Scope
    if ($LASTEXITCODE -ne 0) { throw 'Koppelen aan Vercel is mislukt.' }

    & node (Join-Path $PSScriptRoot 'build-static.cjs')
    if ($LASTEXITCODE -ne 0) { throw 'Verzamelen van publieke bestanden is mislukt.' }
    $output = Join-Path $root '.vercel\output'
    if (Test-Path -LiteralPath $output) {
        Remove-Item -LiteralPath $output -Recurse -Force
    }
    New-Item -ItemType Directory -Path $output -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $root 'public') -Destination (Join-Path $output 'static') -Recurse
    '{"version":3}' | Set-Content -LiteralPath (Join-Path $output 'config.json') -Encoding utf8

    $result = @(& npx --yes vercel@65.1.0 deploy --prebuilt --prod --yes --scope $Scope --json)
    if ($LASTEXITCODE -ne 0) { throw 'Publiceren op Vercel is mislukt.' }
    $deployment = ($result -join "`n") | ConvertFrom-Json
    if ($deployment.status -ne 'ok' -or $deployment.deployment.readyState -ne 'READY') {
        throw 'Vercel meldt geen gereedstaande deployment.'
    }
    $productionUrl = $deployment.deployment.productionUrl
    if ($productionUrl -notmatch '^https://[a-z0-9.-]+/?$') {
        throw 'Vercel heeft geen geldige productie-URL teruggegeven.'
    }

    $quizUrl = "$($productionUrl.TrimEnd('/'))/$QuizPage"
    $response = Invoke-WebRequest -Uri $quizUrl
    if ($response.StatusCode -ne 200 -or $response.Content -notmatch '<html') {
        throw "De gepubliceerde toets is niet bereikbaar: $quizUrl"
    }
    Write-Output "Deployment: $productionUrl"
    Write-Output "Toets: $quizUrl"
}
finally {
    Pop-Location
}
