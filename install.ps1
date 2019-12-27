. "$PSScriptRoot\Scoop.ps1"

ScoopBucket extras
ScoopBucket java

# Show status just for update checks
scoop status

$Packages = @(
  "git",
  "neovim",
  "yarn",
  "fzf",
  "aws",
  "ctags",
  "hub",
  "nodejs",
  "dbeaver",
  "hyper",
  "gpg4win",
  "openjdk",
  "python"
)
foreach ($Package in $Packages) {
  ScoopInstall $Package
}

python -m pip install --upgrade pip
pip install awslogs

# Configure ctags
Copy-Item $PSScriptRoot\.ctags -Destination $HOME\.ctags

# Configure git
Copy-Item $PSScriptRoot\.gitconfig -Destination $HOME\.gitconfig

# Configure hyper
New-Item -Path $env:AppData\Hyper -ItemType Directory -Force
Copy-Item $PSScriptRoot\.hyper.js -Destination $env:AppData\Hyper\.hyper.js

# Configure nvim
New-Item -Path $env:LocalAppData\nvim -ItemType Directory -Force
Copy-Item $PSScriptRoot\init.vim -Destination $env:LocalAppData\nvim\init.vim
nvim +'PlugInstall --sync' +qa

# Yarn packages
yarn global add typescript typescript-language-server prettier jest

# Caps lock should be control
reg import C:\Users\alanj\OneDrive\Config\caps_lock_to_control.reg

# Install hyper-v
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).State -ne "Enabled") {
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -LogLevel 2
}
