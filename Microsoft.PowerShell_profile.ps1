$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
if (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }
# if you don't already have this configured...
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$DownloadsFolder = (Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{374DE290-123F-4565-9164-39C4925E467B}').'{374DE290-123F-4565-9164-39C4925E467B}'
$DocumentsFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)
$DesktopFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

New-PSDrive -Name Downloads -PSProvider FileSystem -Root $DownloadsFolder | Out-Null
New-PSDrive -Name Documents -PSProvider FileSystem -Root $DocumentsFolder | Out-Null
New-PSDrive -Name Desktop -PSProvider FileSystem -Root $DesktopFolder | Out-Null