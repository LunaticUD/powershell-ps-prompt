function Prompt {
		$curdir = "$(Get-Location)".Split("\") | Select-Object -Last 1
		return "🌐" + "/" + $curdir + "/"  + "💬 "
}
function rmrf ($dir_path){
  Remove-Item -Recurse -Force $dir_path
}
function mv($file_path, $des_name) {
  Move-Item -Path $file_path -Destination $des_name
}
function head($dir_path, $num){
		type $dir_path | Select -First $num
}
function tail($dir_path, $num){
		type $dir_path | Select -Last $num
}

Set-Alias py python

function jp {
    jupyter notebook --ServerApp.root_dir=C:/Users/WZL/Downloads @args
}

#region mamba initialize
# !! Contents within this block are managed by 'mamba shell init' !!
$Env:MAMBA_ROOT_PREFIX = "E:\Miniforge3"
$Env:MAMBA_EXE = "E:\Miniforge3\Library\bin\mamba.exe"

if (Test-Path $Env:MAMBA_EXE) {
    (& $Env:MAMBA_EXE shell hook -s powershell -r $Env:MAMBA_ROOT_PREFIX) |
        Out-String |
        Invoke-Expression
}
#endregion

