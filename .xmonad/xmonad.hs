import XMonad

main = xmonad $ defaultConfig
    { borderWidth        = 1
    , terminal           = "xterm"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00" }

-- Mod4Mask - windows key
