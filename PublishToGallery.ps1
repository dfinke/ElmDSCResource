$p = @{
    Name = "ElmDSCResource"
    NuGetApiKey = $NuGetApiKey
    LicenseUri = "https://raw.githubusercontent.com/dfinke/ElmDSCResource/master/LICENSE.txt"
    Tag = "Elm","DSC"
    ReleaseNote = "PowerShell DSC Resource provider that compiles files written in the Elm language"
    ProjectUri = "https://github.com/dfinke/ElmDSCResource"
}

Publish-Module @p