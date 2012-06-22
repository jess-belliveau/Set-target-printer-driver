# Set-target-printer-driver

## SYNOPSIS

A powershell script to take each print queue using a specific driver and change to another selected driver

## PARAMETER

None - script will prompt for required parameters

## DESCRIPTION

The script will change all drivers for printers matching the targeted printer driver.
Script does the following:
- Prompts user for print server
- Lists available driver choices and prompts user to select one as target
- User is also prompted to select a replacement driver
- List all printers using this target driver and confirm with user
- Replace targeted drivers with replacement drivers
- Output updated list of drivers