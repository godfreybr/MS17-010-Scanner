# TITLE: MS17-010-Scanner
# AUTHOR: Brennan Godfrey
# DESCRIPTION: Scans local machine & list of network devices for MS17-010 hotfixes
# VERSION: 1.2
# DATE: 16/05/2017

# List of machines to be scanned on the network
# Format: @("MyServer01","MyServer02","MyServer03")
# Leave empty if you wish to only scan the local system
$computerList = @()

# Old, superseded hotfixes
$hotfixes_old = ("KB4012217", "KB4015551", "KB4012216", "KB4015550", "KB4013429", "KB4015217", "KB4015438", "KB4016635")

# Current hotfixes
$hotfixes_latest = ("KB4012598","KB4019472","KB4019473","KB4019474","KB4019215","KB4012213","KB4019216","KB4019264","KB4012212")


#################################
# DO NOT MODIFY BELOW THIS LINE #
#################################

# Get current computer
$computerList += @(hostname)

Write-Host "=================================================================="
Write-Host "Solutions IT - MS17-010-Scanner"
Write-Host "Using the patch requirements spreadsheet, ensure each machine"
Write-Host "is running the latest hotfixes."
Write-Host "=================================================================="

foreach ($computer in $computerList) {

    Write-Host ""
	Write-Host "=================================================================="
	Write-Host "Hotfix report for:" $computer
	Write-Host "=================================================================="

    # Get old hotfixes
	$hotfixs = Get-HotFix -ComputerName $computer | Where-Object {$hotfixes_old -contains $_.HotfixID} | Select-Object -property "HotFixID"
    # Get current hotfixes
	$hotfixs_new = Get-HotFix -ComputerName $computer | Where-Object {$hotfixes_latest -contains $_.HotfixID} | Select-Object -property "HotFixID"

    # Output all old hotfixes
	Write-Host "Outdated hotfixes:"
	foreach ($hotfix in $hotfixs) {
		Write-Host " *" $hotfix.HotFixID
	}

    # Output all new hotfixes
	Write-Host "Current hotfixes:"
	if($hotfixs_new.Count -eq 0)
	{
		Write-Host "!!! WARNING: NO CURRENT HOTFIXES FOUND !!!" -backgroundcolor "red"
	} else {
		foreach ($hotfix_new in $hotfixs_new) {
			Write-Host " *" $hotfix_new.HotFixID
		}
	}
}

Read-Host -Prompt "Press Enter to continue"