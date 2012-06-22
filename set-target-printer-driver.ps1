<#
.SYNOPSIS
Take each print queue using a specific driver and change to another selected driver
.PARAMETER
None - script will prompt for required parameters
.DESCRIPTION
The script will change all drivers for printers matching the targeted printer driver.
Script does the following:
- Prompts user for print server
- Lists available driver choices and prompts user to select one as target
- User is also prompted to select a replacement driver
- List all printers using this target driver and confirm with user
- Replace targeted drivers with replacement drivers
- Output updated list of drivers
#>

# Lets ask the user for a target print server eg; localhost
$printserver = read-Host "Enter print server to query"
# Query the server for its print queues and store the name, driver name and port name.
$printers = Get-WMIObject -class Win32_Printer -computer $printserver | Select Name,DriverName,PortName
# Output the printers for users to view
$printers

# Ask the user which print driver they would like to target and which driver to change to
$target_driver = read-Host "Please provide your target driver name"
$replacement_driver = read-Host "Please provide the replacement driver name"

# Capture the printers with matching target driver name
write-Host "Targeted printers:"
$targeted_printers = Get-WMIObject -class Win32_Printer -computer $printserver | where-Object {$_.DriverName -eq $target_driver}
# Output targeted printers
$targeted_printers

# Ask the user to confirm they would like to replace the listed printers with the replacement driver
$confirmation = read-Host "Confirm you would like to replace the above printers - Y / N"
# Lame check for all Y variants - will improve with a regex
If ( ($confirmation -eq "Y" ) -or ( $confirmation -eq "y" ) -or ( $confirmation -eq "yes" ) ) {
	# Lets replace the drivers for the targeted printers
	Foreach	( $printer in $targeted_printers ) {
		Set-WMIInstance -InputObject $printer -PutType UpdateOnly -argument @{DriverName=$replacement_driver}			
	}
}

# Lets then do a confirmation run
write-host	"The Following printers have been updated - please confirm correct driver in place"
$processed_printers = Get-WMIObject -class Win32_Printer -computer $printserver | where-Object {$_.DriverName -eq $target_driver}
$processed_printers