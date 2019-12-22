#
#   Tag and push to remote repository
#
$version = (Get-Content .\app.json | ConvertFrom-Json | Select-Object version).version

Write-Host "Tagging repository with v$version"
git tag -a "v$version" -m "Version $version"
git push origin --tags