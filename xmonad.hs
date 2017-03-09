import System.IO

import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
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
  xmonad $ FS.fullscreenSupport $ ewmh defaultConfig  { terminal = "urxvtc"
                                                      , modMask = myModMask
                                                      , normalBorderColor = colorGray
                                                      , focusedBorderColor = colorGreen
                                                      , logHook = myLogHook statusBar
                                                      , workspaces = myWorkspaces
                                                      , startupHook = setWMName "LG3D"
                                                      , layoutHook = avoidStruts $ (toggleLayouts (noBorders Full)
                                                            $ onWorkspace "5" simplestFloat
                                                            $ myLayout)
                                                      , manageHook = manageDocks <+> mymanageHook
                                                      , handleEventHook = docksEventHook <+> fullscreenEventHook
                                                      }
                                                      `additionalKeys`
                                                      [ ((0 , 0x1008FF02), spawn "xbacklight + 10")
                                                      , ((0 , 0x1008FF03), spawn "xbacklight - 10")
                                                      , ((0 , xF86XK_AudioMute),  spawn "sh -c 'pactl set-sink-mute combined toggle && /home/haneta/.local/bin/notify-mute.sh'")
                                                      , ((0 , xF86XK_AudioRaiseVolume), spawn "sh -c 'pactl set-sink-mute combined false ; pactl set-sink-volume combined +5% && /home/haneta/.local/bin/notify-volume.sh'")
                                                      , ((0 , xF86XK_AudioLowerVolume), spawn "sh -c 'pactl set-sink-mute combined false ; pactl set-sink-volume combined -5% && /home/haneta/.local/bin/notify-volume.sh'")
                                                      ]
                                                      `additionalKeysP`
                                                      [ ("M-c", spawn "google-chrome-stable")
    , ("M-8", spawn "xbacklight - 10")
    , ("M-9", spawn "xbacklight + 10")
                                                      ]

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )

myModMask = mod4Mask

myStatusBar =  "xmobar $HOME/.xmonad/xmobarrc"

myLogHook h = dynamicLogWithPP $ mySBPP { ppOutput = hPutStrLn h }

myWorkspaces = [ "1", "2", "3", "4", "5" ]

mySBPP =  xmobarPP  { ppCurrent = xmobarColor "#f0c674" "#1d1f21"
                    , ppTitle   = xmobarColor "#8abeb7" "#1d1f21"
                    }

myLayout = smartSpacing 3 $ gaps [(U, 4), (D, 4), (L, 4), (R, 4)] $ ( ResizableTall 1 (1/204) (119/204) [] ) ||| ( TwoPane (1/204) (119/204) ) ||| Simplest

mymanageHook = composeAll [ isFullscreen  --> doFullFloat
                          , isDialog      --> doCenterFloat
                          ]
