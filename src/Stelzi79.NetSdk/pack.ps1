
nuget pack Package.nuspec -OutputDirectory bin

$nupkg = (Get-Item("./bin/*.nupkg")).Name

$packageName = "Stelzi79.NetSdk"
$version = $nupkg.Replace("$packageName.", "")
$version = $version.Replace(".nupkg", "")
$localPackages = "$ENV:USERPROFILE/.nuget/packages"

Write-Output "$($nupkg): $packageName - $version"
$cachePath = "$localPackages/$packageName/$version"
Write-Output $cachePath


if (Test-Path $cachePath) {
	Remove-Item $cachePath -Recurse -Force
}

nuget delete $packageName $version -src LocalPackageSource -NonInteractive

nuget add .\bin\$nupkg -src ../../.nupkg -NonInteractive