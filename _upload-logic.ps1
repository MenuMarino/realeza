Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$clipsDir = Join-Path $repoRoot "clips"

# --- File picker ---
$filePicker = New-Object System.Windows.Forms.OpenFileDialog
$filePicker.Title = "Select clips to upload"
$filePicker.Filter = "MP4 files (*.mp4)|*.mp4"
$filePicker.Multiselect = $true

if ($filePicker.ShowDialog() -ne "OK" -or $filePicker.FileNames.Count -eq 0) { exit }

$selectedFiles = $filePicker.FileNames

# --- Game picker form ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Realeza - Upload Clips"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Game folder (pick existing or type new):"
$label.Location = New-Object System.Drawing.Point(20, 20)
$label.AutoSize = $true
$form.Controls.Add($label)

$combo = New-Object System.Windows.Forms.ComboBox
$combo.Location = New-Object System.Drawing.Point(20, 50)
$combo.Size = New-Object System.Drawing.Size(340, 25)
$existingGames = Get-ChildItem -Path $clipsDir -Directory | Where-Object { $_.Name -ne ".git" } | ForEach-Object { $_.Name }
$existingGames | ForEach-Object { $combo.Items.Add($_) } | Out-Null
$lolIndex = $combo.Items.IndexOf("lol")
if ($lolIndex -ge 0) { $combo.SelectedIndex = $lolIndex } elseif ($combo.Items.Count -gt 0) { $combo.SelectedIndex = 0 }
$form.Controls.Add($combo)

$infoLabel = New-Object System.Windows.Forms.Label
$infoLabel.Text = "$($selectedFiles.Count) clip(s) selected"
$infoLabel.Location = New-Object System.Drawing.Point(20, 85)
$infoLabel.AutoSize = $true
$form.Controls.Add($infoLabel)

$uploadBtn = New-Object System.Windows.Forms.Button
$uploadBtn.Text = "Upload"
$uploadBtn.Location = New-Object System.Drawing.Point(150, 115)
$uploadBtn.Size = New-Object System.Drawing.Size(100, 30)
$uploadBtn.DialogResult = "OK"
$form.AcceptButton = $uploadBtn
$form.Controls.Add($uploadBtn)

if ($form.ShowDialog() -ne "OK" -or [string]::IsNullOrWhiteSpace($combo.Text)) { exit }

$game = $combo.Text.Trim()
$gameDir = Join-Path $clipsDir $game

if (-not (Test-Path $gameDir)) { New-Item -ItemType Directory -Path $gameDir | Out-Null }

# --- Copy files ---
foreach ($file in $selectedFiles) {
    $dest = Join-Path $gameDir (Split-Path -Leaf $file)
    Copy-Item -Path $file -Destination $dest -Force
}

# --- Git add, commit, push ---
Push-Location $repoRoot
git add clips/
git commit -m "feat: add $($selectedFiles.Count) clip(s) to $game"
git push
Pop-Location

[System.Windows.Forms.MessageBox]::Show(
    "$($selectedFiles.Count) clip(s) uploaded to '$game'.`nThe page will update in a minute.",
    "Realeza",
    "OK",
    "Information"
)
