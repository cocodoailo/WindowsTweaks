# Windows Tweaks

微调 Windows 11 家庭版.

## 必备软件

有些软件我推荐从应用商店（Microsoft Store）安装, 有些软件我推荐从 scoop 安装, 有些软件我推荐从官网下载安装包.

> [!TIP]
> 通过应用商店安装软件不需要开代理, 如果访问不了 Microsoft Store 尝试关闭代理

### 通过 Microsoft Store 搜索安装（获取）

- PowerShell
- Microsoft PowerToys
- Auto Dark Mode
- Visual Studio Code
- Visual Studio (可选)

### 通过 PowerShell 安装

### [scoop](https://scoop.sh/)

Open a PowerShell terminal (version 5.1 or later) and from the PS C:\> prompt, run:

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

### WSL 2

### 通过官网下载安装包安装

- AutoHotkey
- Obsidian

## 配置

### Make PowerShell likes Fish Shell

打开 PowerShell 输入 `code $PROFILE` 编辑 `Microsoft.PowerShell_profile.ps1`. 

```ps1
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs

Set-PSReadLineOption -AddToHistoryHandler {
        param([string]$line)
        return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
}
```

### Windows Terminal


### Remove Cortana

To remove Cortana, please open PowerShell as administrator and run[^how-do-i-disable-the-cortana-shortcut-key]:

```ps1
Get-AppxPackage -Name Microsoft.549981C3F5F10 -AllUsers | Remove-AppxPackage
```

### 系统偏好设置

> [!TIP]
> `Win+I` 打开系统设置

#### 任务切换不显示选项卡

设置 > 系统 > 多任务处理 > 对齐或按 `Alt+Tab` 时显示应用中的标签页：不显示选项卡.

#### 任务栏设置

隐藏搜索按钮: 右击任务栏 > 任务栏设置 > 任务栏项 > 搜索 (隐藏)

关闭小组件: 右击任务栏 > 任务栏设置 > 小组件 (关)

任务栏对齐靠左: 右击任务栏 > 任务栏设置 > 任务栏行为 > 任务栏对齐方式: 靠左

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

[^how-do-i-disable-the-cortana-shortcut-key]: [How do I disable the Cortana shortcut key?](https://learn.microsoft.com/en-us/answers/questions/1367909/how-do-i-disable-the-cortana-shortcut-key)
