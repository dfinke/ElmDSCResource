#
# bingo.elm create by following this video tutorial
#
# https://pragmaticstudio.com/courses/elm

Configuration TestElm {
    param($elmFilePath)

    Import-DSCResource -ModuleName ElmDSCResource

    ElmResource Bingo
    {
        ElmExePath    = "C:\Program Files (x86)\Elm Platform\0.15.1\bin"
        ElmInputFile  = "$($elmFilePath)\bingo\bingo.elm"
        ElmOutputFile = "$($elmFilePath)\bingo\bingo.js"

        Ensure = 'Present'
    }
}

TestElm -elmFilePath $pwd.path

Start-DscConfiguration -Wait -Verbose -Force TestElm