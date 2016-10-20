import System.IO

import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

baseConfig = desktopConfig

main :: IO()
main = do
    xmproc <- spawnPipe myStatusBar 
    xmonad $ baseConfig   { terminal = myTerminal
                          , modMask = myModMask
                          , normalBorderColor = colorGray
                          , focusedBorderColor = colorGreen
                          , startupHook = myStartupHook
                          , logHook = dynamicLogWithPP $ mySBPP
                             { ppOutput = hPutStrLn xmproc
                             , ppVisible = wrap "(" ")"
                             }
                          }
            `additionalKeys`
            [
              ((0 , 0x1008FF02), spawn "xbacklight + 10")
            , ((0 , 0x1008FF03), spawn "xbacklight - 10")
            ]
            `additionalKeysP`
            [
              ("M-c", spawn "chromium")
            ]

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )
myTerminal = "urxvtc"
myModMask = mod4Mask
myStartupHook = do
  spawn "fcitx"
myStatusBar = "xmobar"
mySBPP =  xmobarPP  { ppCurrent xmobarColor #8c9440 #1d1f21
                    }
