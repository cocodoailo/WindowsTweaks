Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs

Set-PSReadLineOption -AddToHistoryHandler {
        param([string]$line)
        return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
}
