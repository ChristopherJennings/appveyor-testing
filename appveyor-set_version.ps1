Write-Output "Checking Tag Version"
$env:CurrentVersion = $env:APPVEYOR_BUILD_VERSION
$tagName = & git describe --abbrev=0 --tags

if ($env:APPVEYOR_REPO_TAG -eq $true) {
  $tagName = $env:APPVEYOR_REPO_TAG_NAME
}

Write-Output "Checking tag for SemVer naming"
$regex = new-object System.Text.RegularExpressions.Regex ('v(?<version>(?<major>[0-9]+).(?<minor>[0-9]+).(?<patch>[0-9]+)-?(?<prerelease>.+)?)', [System.Text.RegularExpressions.RegexOptions]::MultiLine)
$version = $null
$match = $regex.Match($tagName)
if($match.Success) {
  Write-Output "SemVer naming found"
  $env:CurrentVersion = $match.Groups["version"].Value
  $versionWithBuild = $env:CurrentVersion + "+build.$env:APPVEYOR_BUILD_ID"
  Write-Output "Changing version '$env:APPVEYOR_BUILD_VERSION' to '$versionWithBuild'"
  Update-AppveyorBuild -Version "$version+"
}
