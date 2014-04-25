cheatsheet_for "3n" do

    description "@leoj3n's keymappings"
    author      "Joel Kuzmarski", "github.com/leoj3n"
    version     "1.0.0"

    key_separator " "

    key :alt     , "⎇"
    key :caps    , "caps-lock"
    key :command , "⌘"
    key :control , "^"
    key :delete  , "⌦"
    key :enter   , "⌅"
    key :esc     , "⎋"
    key :fn      , "fn"
    key :lcommand, "L⌘"
    key :rcommand, "R⌘"
    key :shift   , "⇧"
    key :space   , "␣" # ▽
    key :tab     , "↹"

    key :gesture_up_left , "⇖"
    key :gesture_up_right, "⇗"
    key :gesture_dn_right, "⇘"
    key :gesture_dn_left , "⇙"
    key :gesture_dn      , "⇓"
    key :gesture_up      , "⇑"
    key :gesture_left    , "⇐"
    key :gesture_right   , "⇒"

    key :arrow_left    , "←"
    key :arrow_up      , "↑"
    key :arrow_right   , "→"
    key :arrow_dn      , "↓"
    key :arrow_up_left , "↖"
    key :arrow_up_right, "↗"
    key :arrow_dn_right, "↘"
    key :arrow_dn_left , "↙"

    section "Remapped" do
    __ _caps, _delete
    __ (_shift _esc), _caps
    __ (_rcommand _lcommand), _esc
    __ (_control _control), (_control _space)
    end

    section "Applications" do
    __ "Dash.app"        , (_fn "~")
    __ "Firefox.app"     , (_fn "f")
    __ "Gitter.app"      , (_fn "e"), (_fn _gesture_dn)
    __ "Google Chrome Canary.app", (_fn "a"), (_fn _gesture_right), (_fn _gesture_dn_right)
    __ "iTerm Overlay"   , (_fn "q"), (_alt "~")
    __ "iTerm.app"       , (_fn "x"), (_fn _gesture_up), (_fn _gesture_up_left)
    __ "MailMate.app"    , (_fn "d")
    __ "nvALT.app"       , (_fn "c"), (_fn "w"), (_fn _gesture_dn_left)
    __ "Path Finder.app" , (_fn "z"), (_fn _gesture_up_right)
    __ "Quicksilver Search DuckDuckGo", (_fn "2")
    __ "Quicksilver Search Google", (_fn "3")
    __ "Quicksilver Search Yubnub", (_fn "1")
    __ "Quicksilver.app" , (_control _space), (_control _control)
    __ "Sublime Text.app", (_fn "s"), (_fn _gesture_left)
    __ "Photoshop.app"   , (_fn "p")
    end

    section "Vim" do
      section "Vim Anywhere" do
      __ "Enter insertion mode", (_control _command "v")
      end

      section "Ubiquitous Vim Bindings" do
      __ "Enter normal mode", (_alt "v")
      __ "Exit normal mode" , (_alt "v"), "i"
      end

      section "VIM Emulation" do
      __ "Enter normal mode", (_control "[")
      __ "Exit normal mode" , "i"
      end
    end

    section "Moom.app" do
    __ "Laptop preset"      , (_command _alt "w")
    __ "Office preset"      , (_command _alt "o")
    __ "Moom current window", (_command _control "w")
      section "Mooming" do
      __ "Move up"     , (_command _arrow_up)
      __ "Move down"   , (_command _arrow_dn)
      __ "Move left"   , (_command _arrow_left)
      __ "Move right"  , (_command _arrow_right)
      __ "Shrink up"   , (_alt _arrow_up)
      __ "Shrink down" , (_alt _arrow_dn)
      __ "Shrink left" , (_alt _arrow_left)
      __ "Shrink right", (_alt _arrow_right)
      __ "Grow up"     , (_control _arrow_up)
      __ "Grow down"   , (_control _arrow_dn)
      __ "Grow left"   , (_control _arrow_left)
      __ "Grow right"  , (_control _arrow_right)
      end
    end

    section "TeamSpeak 3 Client.app" do
    __ "Transmit", (_command _control _shift)
    end

end
