# ============================================================
#  归去来兮辞 · 打开终端时随机显示一句
#  脚本：与当前配置文件同目录的 quote.ps1
#  手动再看一句：gui
#  临时不显示：$env:GUIQULA_QUIET=1
#  想关闭：把下面 $GuiQuoteEnabled 改成 $false
# ============================================================
$GuiQuoteEnabled = $true

if ($GuiQuoteEnabled -and (Test-Path "$PSScriptRoot\quote.ps1")) {
    . "$PSScriptRoot\quote.ps1"
}
. "$PSScriptRoot\ps-prompt.ps1"