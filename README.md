# MS17-010-Scanner
PowerShell scanner for the MS17-010 hotfix list. Will scan a local machine or can scan networked machines for installed hotfixes related to MS17-010. Will first scan for any outdated hotfixes and then scan for the current hotfixes.

## For local scanning
For local scanning, run PowerShell script as is.

## For network scanning
To scan network devices, append network device NetBIOS names to computerList array.
