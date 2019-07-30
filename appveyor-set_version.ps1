Write-Output "Checking Tag Version"
$env:CurrentVersion = $env:APPVEYOR_BUILD_VERSION
$tagName = & git describe --abbrev=0 --tags

if ($env:APPVEYOR_REPO_TAG -eq $true) {
  $tagName = $env:APPVEYOR_REPO_TAG_NAME
}

Write-Output "Checking tag for SemVer naming"
$regex = new-object System.Text.RegularExpressions.Regex ('v(?<version>(?<major>[0-9]+).(?<minor>[0-9]+).(?<patch>[0-9]+)-?(?<prerelease>.+)?)', [System.Text.RegularExpressions.RegexOptions]::MultiLine)
$match = $regex.Match($tagName)
if($match.Success) {
  Write-Output "SemVer naming found"
  $version = $match.Groups["version"].Value

  if ($env:APPVEYOR_REPO_TAG -ne $true) {
    $version = $version + "+devbuild.$env:APPVEYOR_BUILD_NUMBER"
  }

  Write-Output "Changing version '$env:APPVEYOR_BUILD_VERSION' to '$version'"
  Update-AppveyorBuild -Version "$version"
}
