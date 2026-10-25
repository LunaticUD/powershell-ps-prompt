<#
  ============================================================
   终端每日一句 · 庄子
   ------------------------------------------------------------
   收录两类：
     1. 庄子名言 45 句（原文金句）
     2. 庄子寓言故事 20 则（故事名 + 白话点睛）
   每次开终端随机取一条，最近 15 次内不重复。
   数据：脚本同目录的 last.txt
   临时不显示：$env:GUIQULA_QUIET=1
   手动再看一条：gui
  ============================================================
#>

$script:QuoteDir = $PSScriptRoot
$script:LastFile = Join-Path $script:QuoteDir 'last.txt'
$script:Esc      = [char]27

$script:Sources = @(
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
            '巧者劳而知者忧，无能者无所求。',
            '覆杯水于坳堂之上，则芥为之舟。',
            '适莽苍者，三餐而反；适百里者，宿舂粮；适千里者，三月聚粮。',
            '举世而誉之而不加劝，举世而非之而不加沮。',
            '若夫乘天地之正，而御六气之辩，以游无穷者，彼且恶乎待哉！',
            '藐姑射之山，有神人居焉，肌肤若冰雪，淖约若处子。',
            '大言炎炎，小言詹詹。',
            '道行之而成，物谓之而然。',
            '六合之外，圣人存而不论；六合之内，圣人论而不议。',
            '大道不称，大辩不言，大仁不仁，大廉不嗛，大勇不忮。',
            '知止乎其所不能知，至矣。',
            '予恶乎知夫死者不悔其始之蕲生乎！',
            '此之谓物化。',
            '为善无近名，为恶无近刑。',
            '始臣之解牛之时，所见无非牛者；三年之后，未尝见全牛也。',
            '泽雉十步一啄，百步一饮，不蕲畜乎樊中。',
            '安时而处顺，哀乐不能入也。',
            '指穷于为薪，火传也，不知其尽也。',
            '天下有大戒二：其一，命也；其一，义也。',
            '形莫若就，心莫若和。',
            '山木自寇也，膏火自煎也。',
            '桂可食，故伐之；漆可用，故割之。',
            '人皆知有用之用，而莫知无用之用也。',
            '来世不可待，往世不可追也。',
            '福轻乎羽，莫之知载；祸重乎地，莫之知避。',
            '自其异者视之，肝胆楚越也；自其同者视之，万物皆一也。',
            '相视而笑，莫逆于心。',
            '鱼相忘乎江湖，人相忘乎道术。',
            '生也死之徒，死也生之始。',
            '人之生，气之聚也；聚则为生，散则为死。',
            '通天下一气耳。'
        )
    },
    @{
        from   = '庄周《庄子》'
        quotes = @(
            @{ text = '庖丁解牛：刀用十九年还像刚磨过，因为他顺着骨节空隙走，不硬砍。'; from = '庄周《庄子·养生主》' },
            @{ text = '庄周梦蝶：醒来不知是自己梦成蝴蝶，还是蝴蝶梦成自己。'; from = '庄周《庄子·齐物论》' },
            @{ text = '朝三暮四：狙公把「朝三暮四」改成「朝四暮三」，猴子立刻转怒为喜。'; from = '庄周《庄子·齐物论》' },
            @{ text = '罔两问景：影子的影子问影子为何忽行忽止，影子说自己也在等别人。'; from = '庄周《庄子·齐物论》' },
            @{ text = '混沌开窍：南海北海之帝给混沌凿七窍，日凿一窍，七日混沌死。'; from = '庄周《庄子·应帝王》' },
            @{ text = '井底之蛙：坎井之蛙向东海之鳖炫耀一坑水，鳖左脚未入右膝已绊。'; from = '庄周《庄子·秋水》' },
            @{ text = '望洋兴叹：河伯初见大海，才知自己渺小，长见笑于大方之家。'; from = '庄周《庄子·秋水》' },
            @{ text = '濠梁之辩：庄子说鱼乐，惠子问「子非鱼」，庄子答「我知之濠上」。'; from = '庄周《庄子·秋水》' },
            @{ text = '鸱得腐鼠：鹞鹰得一只死鼠，仰头吓凤凰，怕它来抢。'; from = '庄周《庄子·秋水》' },
            @{ text = '曳尾涂中：楚王请庄子做官，他说宁愿活着在泥里摇尾巴。'; from = '庄周《庄子·秋水》' },
            @{ text = '邯郸学步：燕国少年去邯郸学走路，没学会，连原来的走法也忘了。'; from = '庄周《庄子·秋水》' },
            @{ text = '鼓盆而歌：妻子死了，庄子敲盆唱歌，说生死如四季更替。'; from = '庄周《庄子·至乐》' },
            @{ text = '髑髅之乐：骷髅托梦说死后无君无臣，比当国王还快活。'; from = '庄周《庄子·至乐》' },
            @{ text = '鲁侯养鸟：鲁侯用酒肉招待海鸟，鸟眩视忧悲，三日而死。'; from = '庄周《庄子·至乐》' },
            @{ text = '痀偻承蜩：驼背老人粘蝉如拾取，因「唯蜩翼之知」。'; from = '庄周《庄子·达生》' },
            @{ text = '呆若木鸡：斗鸡养到「望之似木鸡」，别的鸡不敢应战。'; from = '庄周《庄子·达生》' },
            @{ text = '运斤成风：匠石挥斧削去郢人鼻尖白灰，鼻不伤，郢人面不改色。'; from = '庄周《庄子·徐无鬼》' },
            @{ text = '涸辙之鲋：车辙鲫鱼求一斗水活命，庄子说去引西江水，鱼说那不如早去干鱼铺找我。'; from = '庄周《庄子·外物》' },
            @{ text = '东施效颦：丑女见西施皱眉很美，也捧心皱眉，邻居闭门不出。'; from = '庄周《庄子·天运》' },
            @{ text = '屠龙之技：朱泙漫花千金学屠龙，三年学成，却无龙可屠。'; from = '庄周《庄子·列御寇》' },
            @{ text = '蜩鸠笑鹏：蝉与小鸟笑大鹏飞那么高图什么，庄子说「之二虫又何知」。'; from = '庄周《庄子·逍遥游》' },
            @{ text = '越俎代庖：庖人不治庖，尸祝不越樽俎代他做。'; from = '庄周《庄子·逍遥游》' },
            @{ text = '大瓠之种：五石大葫芦，惠子嫌无用砸了，庄子说可系在腰上浮江湖。'; from = '庄周《庄子·逍遥游》' },
            @{ text = '不龟手之药：同一种防冻药，有人用来漂丝絮，有人用来打败吴军。'; from = '庄周《庄子·逍遥游》' },
            @{ text = '樗树无用：树臃肿不中绳墨，正因无用，才免于斧斤。'; from = '庄周《庄子·逍遥游》' },
            @{ text = '螳臂当车：螳螂怒举臂挡车辙，不知自己不胜任。'; from = '庄周《庄子·人间世》' },
            @{ text = '楚狂接舆：接舆过孔子门前唱「凤兮凤兮，何如德之衰也」。'; from = '庄周《庄子·人间世》' },
            @{ text = '支离疏：畸形人靠缝洗度日，征兵免身、发粮受三钟，终其天年。'; from = '庄周《庄子·人间世》' },
            @{ text = '王骀无足：断足之人开馆授徒，追随者与孔子门下相等。'; from = '庄周《庄子·德充符》' },
            @{ text = '哀骀它：奇丑无比，男子见了舍不得走，女子宁为其妾。'; from = '庄周《庄子·德充符》' },
            @{ text = '子舆病偻：病成驼背，说造物者要把我变成什么，我就变成什么。'; from = '庄周《庄子·大宗师》' },
            @{ text = '象罔得珠：黄帝丢了玄珠，聪明人找不到，无心的象罔找到了。'; from = '庄周《庄子·天地》' },
            @{ text = '抱瓮灌园：老人不用桔槔，抱瓮浇菜，说有机事者必有机心。'; from = '庄周《庄子·天地》' },
            @{ text = '轮扁斫轮：轮扁说桓公读的书是古人的糟粕，因为精华不可言传。'; from = '庄周《庄子·天道》' },
            @{ text = '林回弃璧：逃难时丢掉千金之璧，背着婴儿跑，说彼以利合、此以天属。'; from = '庄周《庄子·山木》' },
            @{ text = '螳螂捕蝉：蝉得美荫忘身，螳螂捕之忘形，异鹊在后举翼。'; from = '庄周《庄子·山木》' },
            @{ text = '逆旅二妾：店主两个妾，美的被轻贱，丑的被尊重。'; from = '庄周《庄子·山木》' },
            @{ text = '随珠弹雀：用随侯之珠打千仞高的麻雀，世人必笑他得不偿失。'; from = '庄周《庄子·让王》' },
            @{ text = '尾生抱柱：尾生与女子约于桥下，水涨不走，抱柱而死。'; from = '庄周《庄子·盗跖》' },
            @{ text = '探骊得珠：千金之珠必在九重深渊骊龙颔下，须趁其睡时取。'; from = '庄周《庄子·列御寇》' }
        )
    }
)

# 拍平成一个池子，保证每条被抽中的概率一样
# 组内元素可以是纯字符串（沿用组的 from），也可以是带自己 from 的对象
$script:Pool = @()
foreach ($s in $script:Sources) {
    foreach ($q in $s.quotes) {
        if ($q -is [string]) {
            $script:Pool += [pscustomobject]@{ text = "$q"; from = $s.from }
        } else {
            $f = if ($q.from) { "$($q.from)" } else { $s.from }
            $script:Pool += [pscustomobject]@{ text = "$($q.text)"; from = $f }
        }
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

# ---------- 取一条（最近 15 次内不重复） ----------
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

    # 从没在最近历史里出现过的条目中随机挑
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
        # 长句（故事与庄子长句）：去掉「」，按标点折行，每行各自居中
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

# ---------- 手动再看一条 ----------
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
