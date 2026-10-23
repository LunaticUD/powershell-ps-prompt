# PowerShell Prompt

一个零依赖的 PowerShell 单行提示符脚本。无需安装 Oh My Posh、posh-git 或任何扩展，只依靠 PowerShell 与 ANSI 转义序列完成美化。

## 效果

```text
(ori) ~\Downloads\桌宠(main) ❯
```

- `(ori)`：当前 Conda/Mamba 环境，未激活时隐藏。
- `~\Downloads\桌宠`：当前路径，用户主目录会缩写为 `~`。
- `(main)`：当前 Git 分支，不在仓库中时隐藏。
- `❯`：输入提示符。

## 特性

- 紧凑的单行布局。
- 彩色显示环境名、路径和 Git 分支。
- 自动缩写用户主目录。
- 通过读取 `.git/HEAD` 获取分支，不依赖 `git.exe`、posh-git 或后台 Git 命令。
- 支持常规仓库、Git worktree，以及 detached HEAD 的短哈希显示。
- 自动识别 Conda/Mamba 激活环境。
- 在 Windows PowerShell 5.1 中自动开启 ANSI 支持；终端不支持时退化为无颜色提示符。
- 支持 `NO_COLOR` 环境变量关闭颜色。
- 纯 PowerShell 实现，无外部依赖。

## 环境要求

- Windows 10/11。
- Windows PowerShell 5.1（当前已验证）。
- 也设计为兼容 PowerShell 7+。

## 安装

### 临时使用

在当前会话中加载：

```powershell
. "$HOME\Downloads\powershell\ps-prompt.ps1"
```

### 永久启用

打开 PowerShell 配置文件：

```powershell
notepad $PROFILE
```

在文件末尾添加：

```powershell
. "$HOME\Downloads\powershell\ps-prompt.ps1"
```

保存后重新打开终端，或重新加载当前会话：

```powershell
. $PROFILE
```

如果移动了本项目的位置，请同步修改配置文件中的路径。卸载时删除那一行即可。

如果已将 `ps-prompt.ps1` 复制到配置文件所在的同一目录，也可以使用 `$PSScriptRoot` 按相对目录加载：

```powershell
. "$PSScriptRoot\ps-prompt.ps1"
```

注意不要写成 `. "\ps-prompt.ps1"` 或 `. ".\ps-prompt.ps1"`：前者会指向当前盘符根目录，后者依赖启动时的工作目录，都无法稳定定位到脚本。

## 自定义

### 修改颜色

颜色定义在 [ps-prompt.ps1](ps-prompt.ps1) 的 `$palette` 中，使用 ANSI 256 色编号：

| 配置项 | 默认值 | 用途 |
| --- | --- | --- |
| `Env` | `179` | Conda/Mamba 环境名 |
| `Parent` | `245` | 路径中的上级目录 |
| `Leaf` | `255` | 当前目录名（加粗） |
| `Git` | `114` | Git 分支 |
| `Accent` | `81` | 提示符箭头（加粗） |

例如把 Git 分支改成橙色：

```powershell
Git = '38;5;208'
```

修改后重新加载脚本即可生效。

### 关闭颜色

在加载脚本前设置 `NO_COLOR`：

```powershell
$env:NO_COLOR = "1"
. "$HOME\Downloads\powershell\ps-prompt.ps1"
```

### 环境与 Git 信息

- 环境名优先读取 `CONDA_PROMPT_MODIFIER`，其次读取 `CONDA_DEFAULT_ENV`。
- Git 分支从当前目录逐级向上查找 `.git` 元数据，不执行 Git 命令。
- 当前仅显示分支名，不显示未提交更改、ahead/behind 等状态。

## 工作原理

1. 定义一个全局 `prompt` 函数，替换 PowerShell 默认提示符。
2. Windows PowerShell 5.1 下通过 Win32 `SetConsoleMode` 开启 VT/ANSI 支持；失败时自动关闭颜色。
3. 将当前路径拆成上级目录和当前目录，并替换用户主目录为 `~`。
4. 从 `.git/HEAD` 读取当前分支或 detached HEAD 哈希。
5. 从 Conda/Mamba 环境变量读取并显示当前环境。

## 常见问题

### 修改后没有生效

脚本不是自动热加载的，请重新执行：

```powershell
. "$HOME\Downloads\powershell\ps-prompt.ps1"
```

或者重新打开终端。

### 提示符没有颜色

可能的原因：

- 当前宿主不支持 ANSI（例如 PowerShell ISE），脚本会自动使用无颜色模式。
- `NO_COLOR` 已设置。
- 输出被重定向，或终端不支持虚拟终端序列。

建议在 Windows Terminal 中使用。

### 中文路径或箭头乱码

Windows PowerShell 5.1 在中文系统上会按本地 ANSI 代码页读取无 BOM 的脚本。请保持 [ps-prompt.ps1](ps-prompt.ps1) 为 **UTF-8 with BOM** 编码，避免中文和 `›`、`❯` 等字符被错误解析。

### 进入 Git 仓库后没有显示分支

请确认当前目录位于含有 `.git` 的仓库内，且脚本对 `.git/HEAD` 有读取权限。脚本不执行 Git 命令，因此不会计算工作区状态。

### 激活环境后没有显示环境名

脚本会实时读取 `CONDA_PROMPT_MODIFIER` 和 `CONDA_DEFAULT_ENV`。可先检查：

```powershell
$env:CONDA_PROMPT_MODIFIER
$env:CONDA_DEFAULT_ENV
```

两者都为空时，不会显示环境名。

## 文件结构

```text
powershell/
├── ps-prompt.ps1
└── README.md
```
