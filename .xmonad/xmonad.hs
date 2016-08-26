import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.CustomKeys

main = xmonad $ defaultConfig
    { borderWidth        = 0
    , terminal           = "urxvt"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    -- , defaultModMask     = modMask
    }
    , keys = customKeys delkeys inskeys }
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
             , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]

-- keys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
-- keys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
--     [
--     -- launching and killing programs
--     -- %! Launch terminal
--       ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) 
--     -- %! Launch dmenu
--     , ((modMask, xK_p), spawn "dmenu_run") 
--     -- %! Launch gmrun
--     , ((modMask .|. shiftMask, xK_p), spawn "gmrun") 
--     -- %! Close the focused window
--     , ((modMask .|. shiftMask, xK_c), kill) 
-- 
--     -- %! Rotate through the available layout algorithms
--     , ((modMask, xK_space), sendMessage NextLayout) 
--     -- %!  Reset the layouts on the current workspace to default
--     , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf) 
-- 
--     -- %! Resize viewed windows to the correct size
--     , ((modMask, xK_n), refresh) 
-- 
--     -- move focus up or down the window stack
--     -- %! Move focus to the next window
--     , ((modMask, xK_Tab), windows W.focusDown)
--     -- %! Move focus to the previous window
--     , ((modMask .|. shiftMask, xK_Tab), windows W.focusUp)
--     -- %! Move focus to the next window
--     , ((modMask, xK_j), windows W.focusDown)
--     -- %! Move focus to the previous window
--     , ((modMask, xK_k), windows W.focusUp) 
--     -- %! Move focus to the master window
--     , ((modMask, xK_m), windows W.focusMaster) 
-- 
--     -- modifying the window order
--     -- %! Swap the focused window and the master window
--     , ((modMask, xK_Return), windows W.swapMaster)
--     -- %! Swap the focused window with the next window
--     , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
--     -- %! Swap the focused window with the previous window
--     , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
-- 
--     -- resizing the master/slave ratio
--     -- %! Shrink the master area
--     , ((modMask, xK_h), sendMessage Shrink)
--     -- %! Expand the master area
--     , ((modMask, xK_l), sendMessage Expand)
-- 
--     -- floating layer support
--     -- %! Push window back into tiling
--     , ((modMask, xK_t), withFocused $ windows . W.sink)
-- 
--     -- increase or decrease number of windows in the master area
--     -- %! Increment the number of windows in the master area
--     , ((modMask , xK_comma), sendMessage (IncMasterN 1))
--     -- %! Deincrement the number of windows in the master area
--     , ((modMask , xK_period), sendMessage (IncMasterN (-1)))
-- 
--     -- quit, or restart
--     , ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess)) -- %! Quit xmonad
--     -- %! Restart xmonad
--     , ((modMask, xK_q), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
--     -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
--     , ((modMask .|. shiftMask, xK_slash), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
-- 
--     -- repeat the binding for non-American layout keyboards
--     , ((modMask , xK_question), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
--     ]
--     ++
--     [((m .|. mod4Mask, k), windows $ f w) |
--       (k,w) <- zip
--           [ xK_q, xK_w, xK_e, xK_a, xK_s, xK_d, xK_z, xK_x, xK_c ]
--           [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ]
--       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
--     ]
--     ++
--     -- mod-{1,2,3} %! Switch to physical/Xinerama screens 1, 2, or 3
--     -- mod-shift-{1,2,3} %! Move client to screen 1, 2, or 3
--     [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--         | (key, sc) <- zip [1, 2, 3] [0..]
--         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
