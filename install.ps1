. "$PSScriptRoot\Scoop.ps1"

ScoopBucket extras

# Show status just for update checks
scoop status

$Packages = @(
  "git",
  "neovim",
  "yarn",
  "fzf",
  "ctags",
  "hub",
  "nodejs",
  "hyper",
  "gpg4win",
  "youtube-dl",
  "ffmpeg",
  "vcredist2010",
  "ripgrep",
  "doctl",
  "kubectl",
  "terraform",
  "WinDirStat",
  "sysinternals",
  "steam",
  "hub",
  "captura"
)
foreach ($Package in $Packages) {
  ScoopInstall $Package
}

# Configure ctags
Copy-Item $PSScriptRoot\.ctags -Destination $HOME\.ctags

# Configure git
Copy-Item $PSScriptRoot\.gitconfig -Destination $HOME\.gitconfig

# Configure hyper
New-Item -Path $env:AppData\Hyper -ItemType Directory -Force
Copy-Item $PSScriptRoot\.hyper.js -Destination $env:AppData\Hyper\.hyper.js

# Configure nvim
New-Item -Path $env:LocalAppData\nvim -ItemType Directory -Force
New-Item -Path $env:LocalAppData\nvim\autoload -ItemType Directory -Force
Copy-Item $PSScriptRoot\init.vim -Destination $env:LocalAppData\nvim\init.vim
Copy-Item $PSScriptRoot\plug.vim -Destination $env:LocalAppData\nvim\autoload\plug.vim
nvim +'PlugInstall --sync' +qa

# Yarn packages
yarn global add typescript typescript-language-server prettier jest

# Caps lock should be control
reg import $PSScriptRoot\caps_lock_to_control.reg

# Install hyper-v
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).State -ne "Enabled") {
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -LogLevel 2
}
