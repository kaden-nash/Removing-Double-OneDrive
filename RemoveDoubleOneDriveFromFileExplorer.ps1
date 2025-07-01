# Script Name: RemoveDoubleOneDriveFromFileExplorer.ps1
# Description: This PowerShell script modifies a specific registry DWORD value
#              to hide the OneDrive entry from the File Explorer Navigation Pane
#              for the current user.

# !!! IMPORTANT WARNING !!!
# Editing the Windows Registry incorrectly can cause severe system problems.
# ALWAYS back up your registry BEFORE running this script.
# You can back up the specific key by navigating to it in regedit,
# right-clicking the folder ({018D5C66-4533-4307-9B53-224DE2ED1FE6}), and selecting 'Export'.

# --- Configuration ---
# Define the full registry path where the value is located.
# The 'HKCU:' drive maps to HKEY_CURRENT_USER.
# OneDrive: 04271989-C4D2-92DE-F521-AB2DE72060DC
# OneDrive - Personal: 018D5C66-4533-4307-9B53-224DE2ED1FE6
$regPath = "HKCU:\Software\Classes\CLSID\{04271989-C4D2-92DE-F521-AB2DE72060DC}"

# Define the name of the DWORD value to be modified.
$valueName = "System.IsPinnedToNameSpaceTree"

# Define the new value (0 to hide, 1 to show).
# We are setting it to 0 as requested to hide the entry.
$newValue = 0

try {
    # Check if the registry path exists before attempting to modify.
    if (-not (Test-Path $regPath)) {
        exit 1 # Exit script if path not found
    }

    # Set the registry DWORD value.
    # -Force parameter creates the value if it doesn't exist or overwrites it if it does.
    Set-ItemProperty -Path $regPath -Name $valueName -Value $newValue -Force -ErrorAction Stop

} catch {
    exit 1 # Indicate script failure
}

# Set-Content create "HideOneDriveNavigationPane(Silent)" binPath= "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\RegistryEditing\RemoveDoubleOneDriveFromFileExplorer.ps1" DisplayName= "Hide OneDrive Navigation Pane (Silent)" start= auto obj= "LocalSystem"
