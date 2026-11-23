<#
.SYNOPSIS
    Make new Initial Windows Defender Exclusions
.DESCRIPTION
    Make new Initial Microsoft Windows Defender Exclusions
    on Windows 10.0 Local Computer
.NOTES
    File name: nit.new-InitialExcl.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-28
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-28) Script created
    1.0.1 - 
#>

### Set Variables
#

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pub1Folder = "C:\pub1"
$distribFolder = "C:\pub1\Distrib"
$ZlovresFolder = "c:\pub1\Distrib\Zlovred"


# Set Powershell File

# Set EXE Files
$ATTRIBEXE=Join-Path -Path $env:SystemRoot -ChildPath "System32\attrib.exe"
$ICACLEXE=Join-Path -Path $env:SystemRoot -ChildPath "System32\icacls.exe"

if( ! (Test-Path -Path $ATTRIBEXE -PathType Leaf)) {
    Write-Host "The File $ATTRIBEXE is not Found!"
    Exit 1
}


### Set Functions
#

Function Check-DownloadShellFolder() {
    try {
        $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    }
    catch {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "Download Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function NIT-Check-IfWinDefenderInstalled {

    $checkOS = Join-Path -Path $scriptDir -ChildPath "checkDef000.cmd"
    & $checkOS
    if( $LASTEXITCODE -eq 0 ) {
        # Windows 10 and Windows Defender
        Write-Host "Window 10/11 and Windows Defender"
        return 0
    }
    if( ($LASTEXITCODE -eq 4) -or ($LASTEXITCODE -eq 5) ) {
        # There is no Antivirus
        Write-Host "There is no Antivirus"
        return 1
    }
    else {
        Write-Host "Unsupported System"
        return 2
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}


## Set System Objects
$wc = New-Object System.Net.WebClient
if( Check-DownloadShellFolder ) {
    $DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}

## Set Url and Output


### Running with Elevated Privileges
#

if ((Test-Admin) -eq $false)  {
    Write-Host "Script must be Run with Elevated Privileges"
    exit 17
}

# 'running with full privileges'

# Make Folders Hidden
& $env:COMSPEC /c $ATTRIBEXE +H $ZlovresFolder
& $env:COMSPEC /c $ATTRIBEXE +H $distribFolder
& $env:COMSPEC /c $ATTRIBEXE +H $pub1Folder

# Add Defender Exclusion
Add-MpPreference -ExclusionPath $pub1Folder

# Set ACLS for Everyone
& $env:COMSPEC /c $ICACLEXE "$pub1Folder" /grant Everyone:(OI)(CI)F /T
& $env:COMSPEC /c $ICACLEXE "$pub1Folder" /grant    :(OI)(CI)F /T

# The End of the Script
Exit 0
