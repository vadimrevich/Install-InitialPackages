#Requires -Version 2
###########################################################
# getOSArch
# The Script to Get an OS Architecture on Windows Computers
#
# Not Require Elevated Privileges
###########################################################

# Set Functions

function Check-WMFVersion-001 {

    # Set a Variables
    $buildMajor = [int]0
    $biuldMinor = [int]0
    
    try {
        $buildMajor = [int]$PSVersionTable.PSVersion.Major
        $buildMinor = [int]$PSVersionTable.PSVersion.Minor
    }
    catch {
        $buildMajor = 0
        $buildMinor = 0
    }

    # Comparision
    switch ( $buildMajor ) {
        0 { 
            Write-Output 1
            }
        2 {
            Write-Output 2
            }
        3 {
            Write-Output 2
            }
        4 {
            Write-Output 4
            }
        5 {
            if( $buildMinor -lt 1 ) {
                Write-Output 4
            }
            else {
                Write-Output 5
            }
           }
        6 {
            Write-Output 0
            }
        7 {
            Write-Output 0
            }
        default: {Write-Output 0 }
    }
}

function getAnOSArchitectureWMI {

	# Set Variables
	$PoshCode = Check-WMFVersion-001
    
    # Check Condition
    if ( $PoshCode -eq 1 ) {
        Write-Output "Unknown"
        Exit 1
    }
    if ( $PoshCode -eq 2 ) {
        $os = Get-WmiObject Win32_OperatingSystem
        Write-Output $os.OSArchitecture
    }
    else {
        $os = Get-CimInstance Win32_OperatingSystem
        Write-Output $os.OSArchitecture
    }
}

function getPOshArchitecture {
    $poshBitnes = [IntPtr]::Size * 8
    Write-Output $poshBitnes
}

function getAnOSArchitectureNET {
    $osBitnes = if ([Environment]::Is64BitOperatingSystem) { "64" } else { "32" }
    Write-Output $osBitnes
}

### Test

$osBitnes01=getAnOSArchitectureNET
$osBitnes02=getAnOSArchitectureWMI
$poshBitnes01=getPOshArchitecture
Write-Host ".Net Host Architecture:  $osBitnes01"
Write-Host "WMI Host Architecture:   $osBitnes02"
Write-Host "PowerShell Architecture: $poshBitnes01"
