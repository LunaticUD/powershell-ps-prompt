<#
  ============================================================
   终端每日一句 · 每次打开随机一句
   ------------------------------------------------------------
   收录两组：
     1. 陶渊明《归去来兮辞》正文 30 句
     2. 老子《道德经》帛书本（马王堆甲、乙本）经典句 40 句
   每次开终端随机取一句，且不会和上一次重复。
   数据：脚本同目录的 last.txt（记录上次取到的句子序号）
   临时不显示：$env:GUIQULA_QUIET=1
   手动再看一句：gui
  ============================================================
#>

$script:QuoteDir = $PSScriptRoot
$script:LastFile = Join-Path $script:QuoteDir 'last.txt'
$script:Esc      = [char]27

$script:Sources = @(
    @{
        from   = '陶渊明《归去来兮辞》'
        quotes = @(
            '归去来兮，田园将芜胡不归？',
            '既自以心为形役，奚惆怅而独悲？',
            '悟已往之不谏，知来者之可追。',
            '实迷途其未远，觉今是而昨非。',
            '舟遥遥以轻飏，风飘飘而吹衣。',
            '问征夫以前路，恨晨光之熹微。',
            '乃瞻衡宇，载欣载奔。',
            '僮仆欢迎，稚子候门。',
            '三径就荒，松菊犹存。',
            '携幼入室，有酒盈樽。',
            '引壶觞以自酌，眄庭柯以怡颜。',
            '倚南窗以寄傲，审容膝之易安。',
            '园日涉以成趣，门虽设而常关。',
            '策扶老以流憩，时矫首而遐观。',
            '云无心以出岫，鸟倦飞而知还。',
            '景翳翳以将入，抚孤松而盘桓。',
            '归去来兮，请息交以绝游。',
            '世与我而相违，复驾言兮焉求？',
            '悦亲戚之情话，乐琴书以消忧。',
            '农人告余以春及，将有事于西畴。',
            '或命巾车，或棹孤舟。',
            '既窈窕以寻壑，亦崎岖而经丘。',
            '木欣欣以向荣，泉涓涓而始流。',
            '善万物之得时，感吾生之行休。',
            '已矣乎！寓形宇内复几时？',
            '曷不委心任去留？胡为乎遑遑欲何之？',
            '富贵非吾愿，帝乡不可期。',
            '怀良辰以孤往，或植杖而耘耔。',
            '登东皋以舒啸，临清流而赋诗。',
            '聊乘化以归尽，乐夫天命复奚疑！'
        )
    },
    @{
        from   = '老子《道德经》帛书本'
        quotes = @(
            '道可道也，非恒道也；名可名也，非恒名也。',
            '无名，万物之始也；有名，万物之母也。',
            '玄之又玄，众妙之门。',
            '有无之相生也，难易之相成也，长短之相形也。',
            '是以圣人居无为之事，行不言之教。',
            '持而盈之，不如其已。',
            '三十辐同一毂，当其无，有车之用也。',
            '有之以为利，无之以为用。',
            '五色使人目盲，驰骋田猎使人心发狂。',
            '为学者日益，闻道者日损。',
            '道生一，一生二，二生三，三生万物。',
            '万物负阴而抱阳，中气以为和。',
            '反也者，道之动也；弱也者，道之用也。',
            '天下之物生于有，有生于无。',
            '大方无隅，大器免成，大音希声，大象无形。',
            '知人者智也，自知者明也。',
            '胜人者有力也，自胜者强也。',
            '知足不辱，知止不殆，可以长久。',
            '甚爱必大费，多藏必厚亡。',
            '大成若缺，其用不敝；大盈若盅，其用不穷。',
            '躁胜寒，静胜热，清静可以为天下正。',
            '罪莫大于可欲，祸莫大于不知足。',
            '不出于户，以知天下；不窥于牖，以知天道。',
            '其出也弥远，其知也弥少。',
            '为无为，事无事，味无味。',
            '图难乎其易也，为大乎其细也。',
            '合抱之木，生于毫末；九成之台，作于羸土；百仞之高，始于足下。',
            '夫轻诺必寡信，多易必多难。',
            '江海所以能为百谷王者，以其善下之也。',
            '吾有三宝，持而宝之：一曰慈，二曰俭，三曰不敢为天下先。',
            '祸，福之所倚；福，祸之所伏。',
            '天网恢恢，疏而不失。',
            '天下莫柔弱于水，而攻坚强者莫之能先也。',
            '信言不美，美言不信；知者不博，博者不知。',
            '圣人不积，既以为人，己愈有；既以予人，己愈多。',
            '甘其食，美其服，乐其俗，安其居。',
            '人法地，地法天，天法道，道法自然。',
            '知者弗言，言者弗知。',
            '圣人恒无心，以百姓之心为心。',
            '柔弱胜刚强。'
        )
    },
    @{
        from   = '庄周《庄子》'
        quotes = @(
            '北冥有鱼，其名为鲲。鲲之大，不知其几千里也。',
            '鹏之徙于南冥也，水击三千里，抟扶摇而上者九万里。',
            '天之苍苍，其正色邪？其远而无所至极邪？',
            '且夫水之积也不厚，则其负大舟也无力。',
            '小知不及大知，小年不及大年。',
            '朝菌不知晦朔，蟪蛄不知春秋。',
            '至人无己，神人无功，圣人无名。',
            '鹪鹩巢于深林，不过一枝；偃鼠饮河，不过满腹。',
            '天地与我并生，而万物与我为一。',
            '昔者庄周梦为胡蝶，栩栩然胡蝶也。',
            '大知闲闲，小知间间。',
            '道隐于小成，言隐于荣华。',
            '彼亦一是非，此亦一是非。',
            '吾生也有涯，而知也无涯。以有涯随无涯，殆已！',
            '缘督以为经，可以保身，可以全生。',
            '臣以神遇而不以目视，官知止而神欲行。',
            '彼节者有间，而刀刃者无厚；以无厚入有间，恢恢乎其于游刃必有余地矣。',
            '提刀而立，为之四顾，为之踌躇满志。',
            '乘物以游心，托不得已以养中，至矣。',
            '知其不可奈何而安之若命，德之至也。',
            '无听之以耳而听之以心，无听之以心而听之以气。',
            '虚室生白，吉祥止止。',
            '人莫鉴于流水而鉴于止水，唯止能止众止。',
            '德有所长而形有所忘。',
            '泉涸，鱼相与处于陆，相呴以湿，相濡以沫，不如相忘于江湖。',
            '大块载我以形，劳我以生，佚我以老，息我以死。',
            '堕肢体，黜聪明，离形去知，同于大通，此谓坐忘。',
            '至人之用心若镜，不将不迎，应而不藏。',
            '井蛙不可以语于海者，拘于虚也；夏虫不可以语于冰者，笃于时也。',
            '吾在天地之间，犹小石小木之在大山也。',
            '子非鱼，安知鱼之乐？',
            '以道观之，物无贵贱。',
            '知穷之有命，知通之有时，临大难而不惧者，圣人之勇也。',
            '用志不分，乃凝于神。',
            '以瓦注者巧，以钩注者惮，以黄金注者殙。',
            '君子之交淡若水，小人之交甘若醴。',
            '直木先伐，甘井先竭。',
            '天地有大美而不言，四时有明法而不议，万物有成理而不说。',
            '人生天地之间，若白驹之过隙，忽然而已。',
            '荃者所以在鱼，得鱼而忘荃；言者所以在意，得意而忘言。',
            '日出而作，日入而息，逍遥于天地之间，而心意自得。',
            '独与天地精神往来。',
            '彼窃钩者诛，窃国者为诸侯。',
            '凫胫虽短，续之则忧；鹤胫虽长，断之则悲。',
            '巧者劳而知者忧，无能者无所求。'
        )
    }
)

# 拍平成一个池子，保证每句被抽中的概率一样
$script:Pool = @()
foreach ($s in $script:Sources) {
    foreach ($q in $s.quotes) {
        $script:Pool += [pscustomobject]@{ text = $q; from = $s.from }
    }
}

# ---------- 中文显示宽度（一个汉字占 2 列） ----------
function _CharW([char]$Ch) {
    $c = [int]$Ch
    if (($c -ge 0x1100 -and $c -le 0x115F) -or
        ($c -ge 0x2E80 -and $c -le 0xA4CF) -or
        ($c -ge 0xAC00 -and $c -le 0xD7A3) -or
        ($c -ge 0xF900 -and $c -le 0xFAFF) -or
        ($c -ge 0xFE30 -and $c -le 0xFE6F) -or
        ($c -ge 0xFF00 -and $c -le 0xFF60) -or
        ($c -ge 0xFFE0 -and $c -le 0xFFE6)) { return 2 }
    return 1
}

function _QW([string]$Text) {
    if (-not $Text) { return 0 }
    $w = 0
    foreach ($ch in $Text.ToCharArray()) { $w += (_CharW $ch) }
    return $w
}

# 长句折行：优先在标点处断开，每行不超过 MaxW 列
function _Wrap([string]$Text, [int]$MaxW) {
    if ((_QW $Text) -le $MaxW) { return @($Text) }

    $marks = '；，。？！、：'
    $lines = @()
    $rest  = $Text

    while ((_QW $rest) -gt $MaxW) {
        $w = 0
        $cut = 0
        $lastPunct = 0
        for ($i = 0; $i -lt $rest.Length; $i++) {
            $cw = _CharW $rest[$i]
            if ($w + $cw -gt $MaxW) { break }
            $w += $cw
            $cut = $i + 1
            if ($marks.Contains([string]$rest[$i])) { $lastPunct = $i + 1 }
        }
        if ($lastPunct -gt 0) { $cut = $lastPunct }
        if ($cut -le 0) { $cut = 1 }
        $lines += $rest.Substring(0, $cut).Trim()
        $rest = $rest.Substring($cut).Trim()
    }
    if ($rest) { $lines += $rest }
    return $lines
}

function _QC([string]$Code, [string]$Text) {
    if ($env:GUIQULA_PLAIN) { return $Text }
    return "${script:Esc}[${Code}m${Text}${script:Esc}[0m"
}

# ---------- 取一句（最近 15 次内不重复） ----------
function Get-GuiQuote {
    $n = @($script:Pool).Count
    if ($n -le 1) { return $script:Pool[0] }

    # 读取历史记录（逗号分隔的序号）
    $history = @()
    try {
        if (Test-Path -LiteralPath $script:LastFile) {
            $raw = "$(Get-Content -LiteralPath $script:LastFile -Raw)".Trim()
            $history = @($raw -split '[,;\s]+' | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ })
        }
    } catch { }

    # 从没在最近历史里出现过的句子中随机挑
    $candidates = @(0..($n - 1) | Where-Object { $history -notcontains $_ })
    if ($candidates.Count -eq 0) { $candidates = @(0..($n - 1)) }

    $idx = @($candidates | Get-Random)[0]

    # 记录，只保留最近 15 条
    try {
        if (-not (Test-Path -LiteralPath $script:QuoteDir)) {
            New-Item -ItemType Directory -Path $script:QuoteDir -Force | Out-Null
        }
        $history = @($history) + $idx
        if ($history.Count -gt 15) {
            $history = @($history[($history.Count - 15)..($history.Count - 1)])
        }
        Set-Content -LiteralPath $script:LastFile -Value ($history -join ',') -Encoding ASCII
    } catch { }

    return $script:Pool[$idx]
}

# ---------- 显示 ----------
function Show-GuiQuote {
    $q = Get-GuiQuote
    if (-not $q) { return }

    $winW = 80
    try {
        $w = $Host.UI.RawUI.WindowSize.Width
        if ($w -ge 20) { $winW = $w }
    } catch { }

    $avail = $winW - 4
    if ($avail -lt 20) { $avail = 20 }

    $src = '—— ' + $q.from
    $body = '「' + $q.text + '」'

    Write-Host ''

    if ((_QW $body) -le $avail) {
        # 短句：加「」，整行居中
        $pad = [Math]::Max(0, [int](($winW - (_QW $body)) / 2))
        Write-Host ((' ' * $pad) + (_QC '1;36' $body))
    } else {
        # 长句（庄子多长句）：去掉「」，按标点折行，每行各自居中
        foreach ($ln in (_Wrap $q.text $avail)) {
            $pad = [Math]::Max(0, [int](($winW - (_QW $ln)) / 2))
            Write-Host ((' ' * $pad) + (_QC '1;36' $ln))
        }
    }

    Write-Host ''
    $padSrc = [Math]::Max(0, [int](($winW - (_QW $src)) / 2))
    Write-Host ((' ' * $padSrc) + (_QC '90' $src))
    Write-Host ''
}

# ---------- 手动再看一句 ----------
function gui { Show-GuiQuote }

# ---------- 打开终端时自动显示 ----------
try {
    $showIt = $true
    if ($env:GUIQULA_QUIET) { $showIt = $false }
    if ([Console]::IsOutputRedirected) { $showIt = $false }
    if (-not $Host.UI.RawUI) { $showIt = $false }
    # 被 -Command / -File / -NonInteractive 之类调用时不显示，避免污染其他程序输出
    foreach ($a in [Environment]::GetCommandLineArgs()) {
        if ($a -match '^-(c|command|e|ec|encodedcommand|f|file|noninteractive)$') { $showIt = $false; break }
    }
    if ($showIt) { Show-GuiQuote }
} catch {
    # 静默失败，绝不影响终端启动
}
