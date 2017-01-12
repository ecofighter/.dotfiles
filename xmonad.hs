import System.IO

import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.ResizableTile
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
import XMonad.Layout.Simplest
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
    xmonad $ baseConfig   { terminal = "urxvtc"
                          , modMask = myModMask
                          , normalBorderColor = colorGray
                          , focusedBorderColor = colorGreen
                          , logHook = myLogHook statusBar
                          , layoutHook = avoidStruts $ myLayout
                          }
            `additionalKeys`
            [
              ((0 , 0x1008FF02), spawn "xbacklight + 10")
            , ((0 , 0x1008FF03), spawn "xbacklight - 10")
            ]
            `additionalKeysP`
            [
              ("M-c", spawn "google-chrome-stable")
            , ("M-8", spawn "xbacklight - 10")
            , ("M-9", spawn "xbacklight + 10")
            ]

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )
myModMask = mod4Mask
myStatusBar =  "xmobar $HOME/.xmonad/xmobarrc"
myLogHook h = dynamicLogWithPP $ mySBPP { ppOutput = hPutStrLn h }
mySBPP =  xmobarPP  { ppCurrent = xmobarColor "#f0c674" "#1d1f21"
                    , ppTitle   = xmobarColor "#8abeb7" "#1d1f21"
                    }
myLayout = spacing 6
            $ gaps [(U, 8), (D, 8), (L, 8), (R, 8)]
            $ ( ResizableTall 1 (1/204) (119/204) [] )
          ||| ( TwoPane (1/204) (119/204) )
          ||| Simplest
