
.\nuget.exe pack Package.nuspec -OutputDirectory bin


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

.\nuget.exe delete $packageName $version -src LocalPackageSource -NonInteractive

.\nuget.exe add .\bin\$nupkg -src ../../.nupkg -NonInteractive

Remove-Item ./bin/ -Recurse -Force