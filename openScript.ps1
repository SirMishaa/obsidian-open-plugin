param(
    [Parameter(Mandatory=$true)][string]$path = "",
    [string]$vaultName = ""
)

Write-Output $vaultName

if (![System.IO.File]::Exists($path)) {
    throw "The specified path ($path) does not exist."
}

$documentPath = [Environment]::GetFolderPath("MyDocuments")
$obsidianPath = Join-Path -Path $documentPath -ChildPath "Obsidian"

if (![System.IO.Directory]::Exists($obsidianPath)) {
    throw "Obsidian folder not found: $obsidianPath"
}

$obsidianVaultPath = Join-Path -Path $obsidianPath -ChildPath $(if ($vaultName -eq $null) {$Env::ObsidianVaultName} else {$vaultName})

Write-Output "Environement variables is: " + $Env::ObsidianVaultName

if (![System.IO.Directory]::Exists($obsidianVaultPath)) {
    throw "Obsidian vault folder not found: $obsidianVaultPath. You may have to set the environment variable OBSIDIAN_VAULT_NAME to the name of your vault."
}

try
{
    Copy-Item -Path $path -Destination $obsidianVaultPath
    Write-Output "Successfully copied $path to $obsidianVaultPath"
}
catch
{
    Write-Output "Error copying file to vault: $_"
    Write-Error $_
}
