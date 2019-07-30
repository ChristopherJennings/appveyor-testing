Write-Output "Checking Tag Version"
if ($env:APPVEYOR_REPO_TAG -eq $true) {
  Write-Output "Build triggered from tag, checking for SemVer naming"
  $regex = new-object System.Text.RegularExpressions.Regex ('v(?<version>(?<major>[0-9]+).(?<minor>[0-9]+).(?<patch>[0-9]+)-?(?<prerelease>.+)?)', [System.Text.RegularExpressions.RegexOptions]::MultiLine)
  $version = $null
  $match = $regex.Match($env:APPVEYOR_REPO_TAG_NAME)
  if($match.Success) {
    Write-Output "SemVer naming found"
    $version = $match.Groups["version"].Value + "+build.$env:APPVEYOR_BUILD_ID"
    Write-Output "Changing version '$env:APPVEYOR_BUILD_VERSION' to '$version'"
    Update-AppveyorBuild -Version "$version"
  }
} else {
  Write-Output "Build not triggered from tag, no version change necessary"
}
