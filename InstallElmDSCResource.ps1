$dscResource = "ElmDSCResource"
$modulePath = "C:\Program Files\WindowsPowerShell\Modules"
$dscResourcePath = "$modulePath\$dscResource"

rm -Force -Recurse $dscResourcePath -ErrorAction SilentlyContinue

$null = md $dscResourcePath

Copy-Item .\ElmDSCResource.psd1 $dscResourcePath -Verbose
Copy-Item .\ElmDSCResource.psm1 $dscResourcePath -Verbose