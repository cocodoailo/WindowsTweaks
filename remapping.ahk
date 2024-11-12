; Change Caps Lock to Control when held down; otherwise, Escape
;
; Originally based on the comment provided in
; [this](https://gist.github.com/volks73/1e889e01ad0a736159a5d56268a300a8?permalink_comment_id=4688167#gistcomment-4688167)
; Github Gist.
;
; A shortcut should be created for this script and placed in the Windows 10/11
; user's startup folder to automatically enable the feature on boot/startup.
; The user's startup folder can be found using the following steps:
;
; 1. Windows Key+R. The _Run_ dialog will appear.
; 2. Enter the following: `shell:startup`
; 3. Press Enter key. A file explorer dialog will appear.
;
; Obviously, [AutoHotkey v2.0](https://autohotkey.com/) must be installed for this to work.

#Requires AutoHotkey v2.0

; SetCapsLockState "AlwaysOff"

*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey == "CapsLock") {
        if (A_TimeSincePriorHotkey < 1000) {
            Suspend "1"
            Send "{Esc}"
            Suspend "0"
        }
    }
}

Esc::CapsLock
