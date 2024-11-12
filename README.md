# Windows Tweaks

微调 Windows 11 家庭版. 欢迎分享你的 Windows/WSL 使用技巧 [CONTRIBUTING.md](./CONTRIBUTING.md).

> [!IMPORTANT]
> 本文所说的 **PowerShell 是黑色图标的 PowerShell**, 不是那个蓝色图标的 Windows PowerShell. [安装 PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) 打开命令行运行:
> 
> ```ps1
> winget install --id Microsoft.PowerShell --source winget
> ```

> [!TIP]
> 如果终端下载失败或者下载很慢, 推荐开启代理软件的 TUN 模式或者设置终端代理.

## 必备软件

有些软件我推荐从应用商店（Microsoft Store）安装, 有些软件我推荐从 scoop 安装, 有些软件我推荐从官网下载安装包.

> [!TIP]
> 通过应用商店安装软件不需要开代理, 如果访问不了 Microsoft Store 尝试关闭代理

### 通过 Microsoft Store 搜索安装（获取）

从 Microsoft Store 获取和使用 `winget` 安装是一样的, 你也可以通过 `winget` 安装.

- PowerShell
- Microsoft PowerToys
- Auto Dark Mode
- Visual Studio Code
- Visual Studio (可选)

### 通过 PowerShell 安装

#### [scoop](https://scoop.sh/)

Open a PowerShell terminal (version 5.1 or later) and from the PS C:\> prompt, run:

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

#### Git

从 scoop 安装 Git 然后再安装 WSL, 这样在 PowerShell 输入 `bash` 可以打开 git-bash. 可以在 git-bash 下使用 `ssh-copy-id`.

```ps1
scoop install git
```

如果希望 Windows 就有 `ssh-copy-id` 可以安装 git-with-openssh:

```ps1
scoop install git-with-openssh
```

#### WSL 2

You can now install everything you need to run WSL with a single command. Open PowerShell or Windows Command Prompt in administrator mode by right-clicking and selecting "Run as administrator", enter the wsl --install command, then restart your machine.[^wsl_install]

```ps1
wsl --install
```

> [!WARNING]
> *wsl: 检测到 localhost 代理配置，但未镜像到 WSL。NAT 模式下的 WSL 不支持 localhost 代理。*
>
> 打开 PowerShell 输入 `code %USERPROFILE%\.wslconfig` 添加下面的内容配置网络[^wsl_localhost_proxy]:
> ```
> [experimental]
> autoMemoryReclaim=gradual
> networkingMode=mirrored
> dnsTunneling=true
> firewall=true
> autoProxy=true
> ```
>
> 运行 `wsl --shutdown` 关闭 WSL, 重新打开 WSL 生效.

### 通过官网下载安装包安装

- AutoHotkey
- Obsidian

## 配置

### 映射 CapsLk 为 Ctrl 和 ESC

安装 AutoHotkey:

```ps1
winget install --id AutoHotkey.AutoHotkey --source winget
```

下载 remapping.ahk 到自动启动目录, 打开 PowerShell 运行:

```ps1
curl -fLo "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\remapping.ahk" --create-dirs https://raw.githubusercontent.com/cocodoailo/WindowsTweaks/refs/heads/main/remapping.ahk
```

> [!TIP]
> 放到自动启动目录后会在每次开机后运行, `Win+R` 打开运行, 输入 `shell:startup` 回车即可打开自动启动目录. 双击 `remapping.ahk` 即可手动启动脚本.

### 让 PowerShell 类似 Fish Shell

设置 PowerShell 命令行类似 Linux 的命令行. 可以用 `Ctrl+D` 退出终端. 不记录以空格或者 `;` 开始的命令到历史记录. 打开 PowerShell 输入 `code $PROFILE` 编辑 `Microsoft.PowerShell_profile.ps1`[^Temporarily_disabling_command_history]. 

```ps1
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs

Set-PSReadLineOption -AddToHistoryHandler {
        param([string]$line)
        return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
}
```

如果你觉得打开文件再复制粘贴麻烦, 也可以使用这条命令一键设置:

```ps1
curl -fLo $PROFILE --create-dirs https://raw.githubusercontent.com/cocodoailo/WindowsTweaks/refs/heads/main/Microsoft.PowerShell_profile.ps1
```

### Windows Terminal

推荐设置默认配置文件为 PowerShell. 打开设置 JSON 文件修改 copy 和 paste 的 `"keys"` 为 `"ctrl+shift+c"` 和 `"ctrl+shift+v"`.

你可以在 https://windowsterminalthemes.dev/ 找到 Windows Terminal 的配色方案. 粘贴到 JSON 配置文件的 `"schemes"`. 我喜欢使用 GruvboxDarkHard, 并在 Windows Terminal 设置 > 配置文件 > 默认值 > 外观 > 自动调整无法区分的文本亮度 (始终)

### 禁用 LenovoFnAndFunctionKeys 服务 (可能是小新独有的问题)

这个服务会导致按 `Fn+Ctrl` 很烦, `WIN + R` 打开运行, 输入 `cmd`, 按 `ctrl+shift+enter` 以管理员身份启动 `cmd` 运行:

```ps1
sc config LenovoFnAndFunctionKeys start=disabled
net stop LenovoFnAndFunctionKeys
```

### 小技巧

#### 设置终端代理

### 系统偏好设置

> [!TIP]
> `Win+I` 打开系统设置

#### 任务切换不显示选项卡

设置 > 系统 > 多任务处理 > 对齐或按 `Alt+Tab` 时显示应用中的标签页：不显示选项卡.

#### 任务栏设置

隐藏搜索按钮: 右击任务栏 > 任务栏设置 > 任务栏项 > 搜索 (隐藏)

关闭小组件: 右击任务栏 > 任务栏设置 > 小组件 (关)

任务栏对齐靠左: 右击任务栏 > 任务栏设置 > 任务栏行为 > 任务栏对齐方式: 靠左

#### 开始菜单设置

"开始"菜单中不显示最近文件和推荐:

设置 > 个性化 > 开始 > 在“开始“菜单中显示推荐的文件、“文件资源管理器”中的最新文件，以及“跳转列表”中的项 (关)

#### 触控板手势

设置 > 蓝牙和其他设备 > 触摸板. 将三指, 四指手势全部关掉. 在高级手势中将三指手势的向左轻扫和向右轻扫设置为切换桌面, 向上和向下轻扫没有什么作用设置为无.

#### 软件偏好设置

个人的软件偏好设置.

##### Edge浏览器

首次启动全部都设置为不允许.

##### Windows 安全中心

全部按照 Windows 安全中心的建议打开.

##### 卸载软件

- 微软电脑管家
- 资讯

## 常见问题

### 获取打开此'ms-cortana2'链接的应用 WIP


[^how-do-i-disable-the-cortana-shortcut-key]: [How do I disable the Cortana shortcut key?](https://learn.microsoft.com/en-us/answers/questions/1367909/how-do-i-disable-the-cortana-shortcut-key)
[^wsl_install]: [https://learn.microsoft.com/en-us/windows/wsl/install](https://learn.microsoft.com/en-us/windows/wsl/install)
[^wsl_localhost_proxy]: [https://github.com/microsoft/WSL/issues/10753#issuecomment-1814839310](https://github.com/microsoft/WSL/issues/10753#issuecomment-1814839310)
[^Temporarily_disabling_command_history]: [Temporarily disabling command history](https://github.com/PowerShell/PSReadLine/issues/2698)
