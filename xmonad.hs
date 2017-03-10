import System.IO

import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe,runInTerm)
import XMonad.Util.EZConfig
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.SimplestFloat
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances
import qualified XMonad.Layout.Fullscreen as FS
import Graphics.X11.ExtraTypes.XF86
colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

baseConfig = desktopConfig

main :: IO()
main = do
  statusBar <- spawnPipe myStatusBar 
  xmonad $ FS.fullscreenSupport $ ewmh defaultConfig  
    { terminal = "urxvtc"
    , modMask = myModMask
    , borderWidth = 4
    , normalBorderColor = "#262626"
    , focusedBorderColor = "#aaaaaa"
    , logHook = myLogHook statusBar
    , workspaces = myWorkspaces
    , startupHook = setWMName "LG3D"
    , layoutHook = avoidStruts layout
    , manageHook = manageDocks <+> mymanageHook <+> raiseHook
    , handleEventHook = docksEventHook <+> fullscreenEventHook 
    }
    `additionalKeys`
    [ ((0 , xF86XK_AudioMute),  spawn "/home/haneta/.local/bin/mute-toggle.sh")
    , ((0 , xF86XK_AudioRaiseVolume), spawn "/home/haneta/.local/bin/volume-change.sh '+'")
    , ((0 , xF86XK_AudioLowerVolume), spawn "/home/haneta/.local/bin/volume-change.sh '-'")
    ]
    `additionalKeysP`
    [ ("M-c", runOrRaise "google-chrome-stable" (className =? "Google-chrome"))
    , ("M-8", spawn "xbacklight - 10")
    , ("M-9", spawn "xbacklight + 10")
    , ("M-f", sendMessage $ MT.Toggle NBFULL) 
    , ("M-S-f", withFocused float)
    , ("M-S-h", sendMessage MirrorShrink)
    , ("M-S-l", sendMessage MirrorExpand)
    ]

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )

myModMask = mod4Mask

myStatusBar =  "xmobar $HOME/.xmonad/xmobarrc"

myLogHook h = dynamicLogWithPP $ mySBPP { ppOutput = hPutStrLn h }

myWorkspaces = [ "1", "2", "3", "4", "5" ]

mySBPP =  xmobarPP  { ppCurrent = xmobarColor "#f0c674" "#1d1f21"
                    , ppTitle   = xmobarColor "#8abeb7" "#1d1f21" }

myLayout = MT.mkToggle1 NBFULL $ smartBorders
                                $ (( named "RTall"  $ spacing ( ResizableTall 1 (3/100) (1/2) [] ))
                                  ||| ( named "TwoPane" $ spacing (TwoPane (3/100) (1/2)) ))
                                  where
                                    spacing = smartSpacing 6 . gaps [(U, 4), (D, 4), (L, 4), (R, 4)] 

layout = toggleLayouts (noBorders Full) $ onWorkspace "5" simplestFloat $ myLayout

mymanageHook = composeAll [ isFullscreen  --> doFullFloat
                          , isDialog      --> doCenterFloat
                          , className =? "mpv" --> doCenterFloat ]
