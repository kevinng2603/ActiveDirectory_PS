# This script creates multiple users in Active Directory

# ----- Edit these Variables for your own Use Case ----- #
$PASSWORD_FOR_USERS   = "Password1"
# Get the content of the names file
$USER_FIRST_LAST_LIST = Get-Content .\names.txt
# ------------------------------------------------------ #

# -- Take plain text password and create password object -- #
$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force 
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false


# Loop through each name and create the user
foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower() 
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    # Create the user in Active Directory
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "OU=_USERS,$(([ADSI]`"").DistinguishedName)" `
               -Enabled $true
}
