# version tester
function Test-SemVer {
  Param ([string]$text)
  $regex = new-object System.Text.RegularExpressions.Regex ('v(?<versionwithprerelease>(?<version>(?<major>[0-9]+).(?<minor>[0-9]+).(?<patch>[0-9]+))(-(?<prerelease>.+))?)', [System.Text.RegularExpressions.RegexOptions]::MultiLine)
  $match = $regex.Match($text)
  if($match.Success) {
    Write-Output ""
    Write-Output "'$text' matched:"
    Write-Output "- Version: $($match.Groups['version'].Value)"
    Write-Output "- Version with Prerelease: $($match.Groups['versionwithprerelease'].Value)"
    Write-Output "  - Major: $($match.Groups['major'].Value)"
    Write-Output "  - Minor: $($match.Groups['minor'].Value)"
    Write-Output "  - Patch: $($match.Groups['patch'].Value)"
    Write-Output "  - Prerelease: $($match.Groups['prerelease'].Value)"
  }
}

Test-SemVer "v1.0.0"
Test-SemVer "v1.5.0-alpha"
Test-SemVer "v0.1.0-alpha.2"
Test-SemVer "v1.0.0alpha.2"
Test-SemVer "1.0.0-alpha.2"
Test-SemVer "v1.0.0-alpha.2+build.2"