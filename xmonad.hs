import System.IO

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)

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

toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )
myTerminal = "urxvtc -e fish"
myModMask = mod4Mask
myStartupHook = do
  spawn "compton"
  spawn "fcitx"
myStatusBar = "xmobar"
mySBPP =  xmobarPP
