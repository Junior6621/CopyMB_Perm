$FUser = Read-Host "Enter the email address (Source) of the user to copy permissions from (homers@emaildomain.com)"
$TUser = Read-Host "Enter the email address (Destination) of the user to paste permissions to (homers@emaildomain.com)"

#Connect-ExchaneOnline
$GPerm = Get-Mailbox | Get-MailboxPermission -User $FUser

$GPerm | ForEach-Object { $_ 
Add-MailboxPermission -Identity $_.Identity -AccessRights FullAccess -InheritanceType All -AutoMapping:$true -User $TUser
Add-RecipientPermission -Identity $_.Identity -AccessRights SendAs -Confirm:$false -Trustee $TUser
}
Write-Host "Here are the permissions we copied from $FUser:" -ForegroundColor Green
$GPerm
Write-Host "Here are the permission for user $TUser:" -ForegroundColor Yellow
Get-Mailbox | Get-MailboxPermission -User $TUser
