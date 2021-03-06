import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.CustomKeys

main = xmonad $ defaultConfig
    { borderWidth        = 0
    , terminal           = "urxvt"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    , keys               = customKeys delkeys inskeys
    }
        where
            delkeys :: XConfig l -> [(KeyMask, KeySym)]
            delkeys XConfig {modMask = modm} =
                [ (modm .|. m, k) | (m, k) <- zip [0, shiftMask] [xK_w, xK_e, xK_r] ]
          
            inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
            inskeys conf@(XConfig {modMask = modm}) =
                [((m .|. mod4Mask, k), windows $ f w) |
                  (k,w) <- zip
                      [ xK_q, xK_w, xK_e, xK_a, xK_s, xK_d, xK_z, xK_x, xK_c ]
                      [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ]
                  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
