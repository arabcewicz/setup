#SingleInstance Force

; Load library
#Include komorebic.lib.ahk
; Load configuration
#Include komorebi.generated.ahk

; Send the ALT key whenever changing focus to force focus changes
AltFocusHack("enable")
; Default to cloaking windows when switching workspaces
WindowHidingBehaviour("cloak")
; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("Insert")
; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Create named workspaces I-V on monitor 0
EnsureNamedWorkspaces(0, "z x c")
EnsureNamedWorkspaces(1, "a s d")
EnsureNamedWorkspaces(2, "q w e")
; You can do the same thing for secondary monitors too
; EnsureNamedWorkspaces(1, "A B C D E F")

; Assign layouts to workspaces, possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack
NamedWorkspaceLayout("z", "bsp")
NamedWorkspaceLayout("x", "bsp")
NamedWorkspaceLayout("c", "bsp")
NamedWorkspaceLayout("a", "rows")
NamedWorkspaceLayout("s", "rows")
NamedWorkspaceLayout("d", "rows")
NamedWorkspaceLayout("q", "bsp")
NamedWorkspaceLayout("w", "bsp")
NamedWorkspaceLayout("e", "bsp")

; Set the gaps around the edge of the screen for a workspace
NamedWorkspacePadding("z", 2)
NamedWorkspacePadding("x", 2)
NamedWorkspacePadding("c", 2)
NamedWorkspacePadding("a", 2)
NamedWorkspacePadding("s", 2)
NamedWorkspacePadding("d", 2)
NamedWorkspacePadding("q", 2)
NamedWorkspacePadding("w", 2)
NamedWorkspacePadding("e", 2)
; Set the gaps between the containers for a workspace
NamedWorkspaceContainerPadding("z", 6)
NamedWorkspaceContainerPadding("x", 6)
NamedWorkspaceContainerPadding("c", 6)
NamedWorkspaceContainerPadding("a", 6)
NamedWorkspaceContainerPadding("s", 6)
NamedWorkspaceContainerPadding("d", 6)
NamedWorkspaceContainerPadding("q", 6)
NamedWorkspaceContainerPadding("w", 6)
NamedWorkspaceContainerPadding("e", 6)

; You can assign specific apps to named workspaces
; NamedWorkspaceRule("exe", "Firefox.exe", "III")

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Uncomment the next lines if you want a visual border around the active window
;komorebic active-window-border-colour 235 219 178 --window-kind single
ActiveWindowBorderColour(235, 219, 178, "single")
ActiveWindowBorderColour(256, 165, 66, "stack")
ActiveWindowBorderColour(255, 51, 153, "monocle")
;komorebic active-window-border-width
ActiveWindowBorderWidth(3)
;komorebic active-window-border-offset 0
ActiveWindowBorderOffset(0)
;komorebic active-window-border enable
ActiveWindowBorder("enable")

CompleteConfiguration()

; Focus windows
#h::Focus("left")
#j::Focus("down")
#k::Focus("up")
#l::Focus("right")

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#+Enter::Promote()

; Resize
$^#l::ResizeAxis("horizontal", "increase")
$^#h::ResizeAxis("horizontal", "decrease")
$^#j::ResizeAxis("vertical", "increase")
$^#k::ResizeAxis("vertical", "decrease")

; Stack windows
$^#+h::Stack("left")
$^#+l::Stack("right")
$^#+k::Stack("up")
$^#+j::Stack("down")
$^#+;::Unstack()
$#[::CycleStack("previous")
$#]::CycleStack("next")


; Manipulate windows
#t::ToggleFloat()
#f::ToggleMonocle()

; Window manager options
#+r::Retile()
#p::TogglePause()

; Layouts
#|::FlipLayout("horizontal")
#_::FlipLayout("vertical")

; Workspaces
#1::FocusWorkspace(0)
#2::FocusWorkspace(1)
#3::FocusWorkspace(2)

; Move windows across workspaces
#+1::MoveToWorkspace(0)
#+2::MoveToWorkspace(1)
#+3::MoveToWorkspace(2)

#z::FocusNamedWorkspace("z")
#x::FocusNamedWorkspace("x")
#c::FocusNamedWorkspace("c")
#a::FocusNamedWorkspace("a")
#s::FocusNamedWorkspace("s")
#d::FocusNamedWorkspace("d")
#q::FocusNamedWorkspace("q")
#w::FocusNamedWorkspace("w")
#e::FocusNamedWorkspace("e")

#+z::MoveToNamedWorkspace("z")
#+x::MoveToNamedWorkspace("x")
#+c::MoveToNamedWorkspace("c")
#+a::MoveToNamedWorkspace("a")
#+s::MoveToNamedWorkspace("s")
#+d::MoveToNamedWorkspace("d")
#+q::MoveToNamedWorkspace("q")
#+w::MoveToNamedWorkspace("w")
#+e::MoveToNamedWorkspace("e")

InitialNamedWorkspaceRule("exe", "thunderbird.exe", "x")
InitialNamedWorkspaceRule("exe", "brave.exe", "q")
InitialNamedWorkspaceRule("exe", "wezterm-gui.exe", "z")

