enum Ensure {
    Absent
    Present
}

[DscResource()]
class ElmResource{

    [DscProperty(Mandatory)]
    [string]$ElmExePath

    [DscProperty(Key)]
    [string]$ElmInputFile

    [DscProperty(Mandatory)]
    [string]$ElmOutputFile

    [DscProperty(Mandatory)]
    [Ensure] $Ensure


    [void] Set() {
        $fileExists = Test-Path $this.ElmOutputFile

        if($this.Ensure -eq 'Present' ) {

          if(!$fileExists) {
                      
            $p = Split-Path -Path $this.ElmInputFile
          
            Write-Verbose "set location to $($p)"
            Set-Location -Path $p                        

            $exe = "$($this.ElmExePath)\elm.exe"
            Write-Verbose "$($exe) make $($this.ElmInputFile) --output $($this.ElmOutputFile) --yes"
            & $exe make $this.ElmInputFile --output $this.ElmOutputFile            
          }

        } else {
            if($fileExists) {
                Remove-Item -Force $this.ElmOutputFile
            }
        }
    }

    [bool] Test() {
        
        $present = $false
        
        $targetFile = Get-ChildItem -Path $this.ElmOutputFile -ErrorAction Ignore
        if($targetFile -ne $null) {$present = $true}

        if($this.Ensure -eq [Ensure]::Present -and $present) {
            Write-Verbose "$($this.ElmOutputFile) found, no further action"            
        } else {
            Write-Verbose "$($this.ElmOutputFile) not found, will do elm make"            
        }
        
        return $present
    }

    [ElmResource] Get() {

        $present = Test-Path $this.ElmOutputFile

        if($present) {

            $this.ElmInputFile = ls $this.ElmOutputFile
            $this.ElmOutputFile = ls $this.ElmOutputFile
            
            $this.Ensure = 'Present'

        } else {
            $this.Ensure = 'Absent'
        }

        return $this
    }
}