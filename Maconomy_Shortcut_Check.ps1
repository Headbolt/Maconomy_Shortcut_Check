###############################################################################################################
#
# ABOUT THIS PROGRAM
#
#   Maconomy_Shortcut_Check.ps1
#   https://github.com/Headbolt/Maconomy_Shortcut_Check
#
#   This script was designed to Check for the existence of specific Maconomy shortcuts
#	and then exit with an appropriate Exit code.
#
#	Intended use is in Microsoft Endpoint Manager, as the "Check" half of a Proactive Remediation Script
#	The "Remediate" half is found here https://github.com/Headbolt/Maconomy_Shortcut_Remediate
#
###############################################################################################################
#
# HISTORY
#
#   Version: 1.1 - 02/02/2023
#
#   - 27/01/2023 - V1.0 - Created by Headbolt
#
#   - 02/02/2023 - V1.1 - Updated by Headbolt
#				Legislating for Maconomy not being installed
#
###############################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################
#
$ExitCode=0 # Setting ExitCode Variable to an initial 0
$global:PathTestResult="0" # Setting Global PathTestResult Variable to an initial 0
#
###############################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################
#
# Defining Functions
#
###############################################################################################################
#
# Path Test Function
#
Function PathTest ($Path){
	$PathTest=(Test-Path $global:Path)
	#
	Write-Host 'Checking For File' $global:Path	
	Write-Host
	If ($PathTest -eq $True)
		{
			Write-Host 'File' $global:Path 'Exists'
			$global:PathTestResult="1"
		}
	Else
		{
			Write-Host 'File' $global:Path 'Does Not Exist'
			$global:PathTestResult="0"
		}
	Write-Host
	Write-Host '###############################################################################################################'
	Write-Host
}
#
###############################################################################################################
#
# End Of Function Definition
#
###############################################################################################################
#
# Begin Processing
#
###############################################################################################################
#
Write-Host
Write-Host '###############################################################################################################'
Write-Host
#
$global:Path="c:\Users\Public\Desktop\Deltek Maconomy 2.5.1.lnk" # Setting the Path variable for this test
PathTest # Testing the if the Path exists
If ($PathTestResult -eq "1")
	{
		$ExitCode++
	}
#
$global:Path="c:\Users\Public\Desktop\Deltek Maconomy 2.5.1 - PROD.lnk" # Setting the Path variable for this test
PathTest # Testing the if the Path exists
If ($PathTestResult -eq "0")
	{
		$ExitCode++
	}
#
$global:Path="C:\Program Files (x86)\Deltek Maconomy 22.101.1\Maconomy.exe" # Setting the Path variable for this test
PathTest # Testing the if the Path exists
If ($PathTestResult -eq "0")
	{
		Write-Host 'Maconomy 2.6.1 Not Installed, not triggering Remediation'
		Write-Host
		Write-Host '###############################################################################################################'
		Write-Host
		$ExitCode=0 # Setting ExitCode Variable back 0 as Maconomy is not Installed
	}
#
Write-Host Exiting with exit code $ExitCode
exit $ExitCode
#
