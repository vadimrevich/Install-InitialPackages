#Requires -Version 2

#######################
# NOTE! This Comandlet require Powershell 2.0 or higher 
# and Windows 6.1 and higher
# Elevated Priveleges is not needed.
#######################

###########################################################
# Check-WMFVersion.ps1
# This Function will Check a powershell WMF version
# and print it at STDOUT
#
# PARAMETERS:	NONE
# RETURNS:	0 if Powershell Core Install
#		1 if Powershell Error
#		2 if WMF 2.0 Install
#		4 if WMF >= 4.0 Install
#		5 if WMF 5.1 Install
###########################################################

function Check-WMFVersion-000 {

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
            Write-Host "0.0" 
            Write-Host "ExitCode 1"
            }
        2 {
            Write-Host "$buildMajor.$buildMinor"
            Write-Host "ExitCode 2"
            }
        3 {
            Write-Host "$buildMajor.$buildMinor"
            Write-Host "ExitCode 2"
            }
        4 {
            Write-Host "$buildMajor.$buildMinor"
            Write-Host "ExitCode 4"
            }
        5 {
            Write-Host "$buildMajor.$buildMinor"
            if( $buildMinor -lt 1 ) {
                Write-Host "ExitCode 4"
            }
            else {
                Write-Host "ExitCode 5"
            }
           }
        6 {
            Write-Host "$buildMajor.$buildMinor"
            Write-Host "ExitCode 0"
            }
        7 {
            Write-Host "$buildMajor.$buildMinor"
            Write-Host "ExitCode 0"
            }
        default: {Write-Host "ExitCode 0" }
    }
}

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

# Set a Variable
Check-WMFVersion-000

Write-Host "ScriptExitCode: $LASTEXITCODE"
Check-WMFVersion-001 

