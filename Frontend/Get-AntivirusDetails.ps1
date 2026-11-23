#Requires -Version 2
###########################################################
# Get-AntivirusCheck.000.ps1
# This script will check if System antivirus is Installed
# and Print Type of the Antivirus
#
# RETURN:
# * 0 if Antivirus is not found or missing test
# * 1 if Windows Defender is installed
# * 2 if Kaspersky Lab Antivirus  is Installed
# * 3 if Other Antivirus is Installed
###########################################################

$VerPS=$PSVersionTable.PSVersion.Major
#Write-Host "PSVersion Major = $VerPs"

if( $VerPS -le 4 ){

try {
$DispName = $(Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Select-Object -Expand DisplayName -First 1 )
}
catch {
	Write-Host "Check Integrity Error or Antivirus is not Found"
	Exit 0
}
}
else {

try {
$DispName = $(Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiVirusProduct -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Select-Object -Expand DisplayName -First 1 )
}
catch {
	Write-Host "Check Integrity Error or Antivirus is not Found"
	Exit 0
}
}
if( [string]::IsNullOrEmpty($DispName)  ) {
	Write-Host "Antivirus is not Found"
	Exit 0
}

$substring01="Windows Defender"
if($DispName -like $substring01) {
	Write-Host "Windows Defender Installed"
	Exit 1
}
$substring02="Kaspersky"
if( $DispName -like $substring02 ) {
	Write-Host "Kaspersky Lab Products are Installed"
	Exit 2
}

$substring02="Dr.Web"
if( $DispName -like $substring02 ) {
	Write-Host "Doctor Web Antivirus Products are Installed"
	Exit 3
}

$substring02="Avast"
if( $DispName -like $substring02 ) {
	Write-Host "Avast Antivirus Products are Installed"
	Exit 3
}

$substring02="NOD32"
if( $DispName -like $substring02 ) {
	Write-Host "Eset Antivirus Products are Installed"
	Exit 3
}

Write-Host "Other antivirus products are installed"
Exit 3

# SIG # Begin signature block
# MIIJdQYJKoZIhvcNAQcCoIIJZjCCCWICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVZBDKNDcypq6jc+UMqar6r6t
# U6agggcSMIIDNTCCAqKgAwIBAgIQmRZ8sJ6WnpBM/gOYGjGCZjAJBgUrDgMCHQUA
# MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEwMC4GA1UE
# CxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3JrMScwJQYD
# VQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNVBAcTB1Nh
# cmF0b3YxCzAJBgNVBAYTAlJVMCAXDTIwMDcyMDA2Mjg0N1oYDzIxMjAwNzIwMDYy
# ODQ2WjApMScwJQYDVQQDEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4w
# gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANDUnk8zGlTyF8GCxB1aULuNpIjq
# DKg5dT2UjOWrxOHgQiYlrqEjC1GPUCwjsS01OgVjv2Z9ukanCPm84m4vhw5AI3oA
# fWQVDV2y88VwicxqyQdBsjhtujZJ2Syw8RgEelGfGaW4KkCffdDaiYTh8Oo2Q/9h
# M4kGar3uvgrxYgBxAgMBAAGjgewwgekwDwYDVR0TAQH/BAUwAwIBBTAgBgNVHQQB
# Af8EFjAUMA4wDAYKKwYBBAGCNwIBFgMCB4AwMAYKKwYBBAGCNwIBCgQiMCCgHoAc
# aHR0cDovL2FudGljcmltaW5hbG9ubGluZS5ydTAdBgNVHSUEFjAUBggrBgEFBQcD
# AwYIKoUDBQEYAg8wYwYDVR0BBFwwWoAQZ+32JfGWOlxSybCD2PIbaaE0MDIxMDAu
# BgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAtMiBDQYIQ
# iC3lDQIjxYZJIDHHKQxk/jAJBgUrDgMCHQUAA4GBAKX+PIfzdDJQSsudzSjT/yBb
# MS/GVjrjGY176sQTsHbjf9ggNQIZkEg4pKBynOj20wKBjVobQW4wgGxv5UvgL/Xs
# hPKE58wDL1+9D1teEEtYntdn8z7WzZC2Rm77mZV+yd+ZabUXi9Ym7VezmHfWrned
# H2P0GNuIEpH6mkYUOUBDMIID1TCCAsGgAwIBAgIQiC3lDQIjxYZJIDHHKQxk/jAJ
# BgUrDgMCHQUAMDIxMDAuBgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWdu
# aW5nIDIwMjAtMiBDQTAgFw0yMDA3MjAwNjI3MzVaGA8yMTIwMDcyMDA2MjczNFow
# gZ8xIzAhBgNVBAMTGk5JVCBDbGFzcyAzIEVWIFNTTCBDQSAtIEc0MTAwLgYDVQQL
# EydOZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIFRydXN0IE5ldHdvcmsxJzAlBgNV
# BAoTHk5ldyBJbnRlcm5ldCBUZWNobm9sb2dpZXMgSW5jLjEQMA4GA1UEBxMHU2Fy
# YXRvdjELMAkGA1UEBhMCUlUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKdX
# 5yJUtXxNKgy5yTse+hEHiWu1VgvRpWAiuoeS03A3Id7uwU/1evXXUSDkl293DkJ9
# 8TDUOl2tOSe9K6CyH62Ea0kRaAWloaO6wH60hjH1LIOR0Xu8v/gj/qTXQEShtZt7
# 2I4zMLC67u/yncy5ZtnTkKfljEYssOmiJIqiAx4dAgMBAAGjggEBMIH+MBIGA1Ud
# EwEB/wQIMAYBAf8CAQUwIAYDVR0EAQH/BBYwFDAOMAwGCisGAQQBgjcCARYDAgeA
# MDAGCisGAQQBgjcCAQoEIjAgoB6AHGh0dHA6Ly9hbnRpY3JpbWluYWxvbmxpbmUu
# cnUwOwYDVR0lBDQwMgYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcDAwYIKwYB
# BQUHAwQGCCqFAwUBGAIPMFcGA1UdAQRQME6AEHiV66FUatLJmUqI8CyehfChNDAy
# MTAwLgYDVQQDEydWZXJpU2lnbiBDbGFzcyAzIENvZGUgU2lnbmluZyAyMDIwLTIg
# Q0GCBLIuGUUwCQYFKw4DAh0FAAOCAQEAAc2GsrnY7lhqifgBxWvKAo909Ag0CE+L
# hjqINvw+dd1krEmWgyGAsCGvYUYI5t5aQ/+6wYMQc5hV3az+c7f79z4Zqy+HBlFM
# F0cwB7kSiyJ5LL9vsN4krXku1GLWbtUINgcYGBkzZEDzm2F0hGjxILH6uD7skZ3p
# EIxJinJezmSZz9dkvkGMRGuy17TT1Mm4j+ggRrRWk24+bLJ2Q9zFJTIdoxeJ6iz7
# G6z+7g718x7rplcYMZaGejv1rT8te62ZHHPvIKaekZ69JX2Om8uFcjUAgzBO06RR
# 6ATm3W4X3QUXiy6hfOHZUVvSjQQ0XxYnyYS/IOaJUtAf6lj+ZnY5fzGCAc0wggHJ
# AgEBMIG0MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEw
# MC4GA1UECxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3Jr
# MScwJQYDVQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNV
# BAcTB1NhcmF0b3YxCzAJBgNVBAYTAlJVAhCZFnywnpaekEz+A5gaMYJmMAkGBSsO
# AwIaBQCgcDAQBgorBgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFjAjBgkqhkiG9w0BCQQx
# FgQUeBfkV8G3Yv9TaN8Nrum+p07iuGgwDQYJKoZIhvcNAQEBBQAEgYA/n9cgFrIb
# SzXfSdqdeTeIQPqeoN7r8yqWl7B/AXgY8778utNxxa6MZHs9soNE1ZoQCgyyuZtF
# vEd3DVZeBpfMCS7hvInqlKTFHsSvVA4yrBmq8yw0EQ+GkJq03nPbROMnCES0KQga
# Y/mJD16bBSdgcUp1pPDIhUiLfxOL+ny/+Q==
# SIG # End signature block
