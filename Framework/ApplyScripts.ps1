################################################################################
#
# \file		ApplyScripts.ps1
# \brief	Apply a bunch of SQL scripts to a database.
# \author	Chris Oldwood
#
################################################################################

set-strictmode -version latest

# Configure error handling
$ErrorActionPreference = 'stop'

trap
{
	write-error $_ -erroraction continue
	exit 1
}

# Validate command line
if ( ($args.count -ne 3) -or ($args[0] -eq '--help') )
{
	if ($args[0] -ne '--help')
	{
		write-output "ERROR: Invalid command line"
	}

	write-output ""
	write-output "USAGE: ApplyScripts <instance> <database> <scripts files>"
	write-output ""
	write-output "e.g. PowerShell -File ApplyScripts.ps1 .\SQLEXPRESS MyDatabase file-list.txt"
	exit 1
}

function apply-script($connection = $(throw "Connection required"),
                      $script = $(throw "Script required"))
{
    $command = $connection.CreateCommand()
    $command.CommandText = $script
    [void]$command.ExecuteNonQuery()
	$command.Dispose()
}

$instance = $args[0]
$database = $args[1]
$scriptsFile = $args[2]

$connectionString = "Data Source=$instance;Initial Catalog=$database;Integrated Security=True"
$connection = new-object System.Data.SqlClient.SqlConnection $connectionString
$connection.Open()

$files = get-content $scriptsFile

foreach ($file in $files)
{
	if ($file -ne '')
	{
		write-output "Applying batch: $file"

		$batch = [System.IO.File]::ReadAllText($file)
		$scripts = $batch -split '^go',0,'Multiline'
		
		foreach ($script in $scripts)
		{
			apply-script $connection $script
		}
	}
}

$connection.Close()
