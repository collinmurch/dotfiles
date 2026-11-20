-- cmd+k clears the terminal; the session picker moves to shift+cmd+k.
rex.bind("cmd+k", "com.superlogical.terminal.clear")
rex.bind("shift+cmd+k", "session.switch")

-- tmux (~/.tmux.conf), prefix ctrl+b
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })
rex.bind("ctrl+b>i", "pane.resize", { amount = 5, direction = "down" })
rex.bind("ctrl+b>o", "pane.resize", { amount = 5, direction = "up" })
rex.bind("ctrl+b>u", "pane.resize", { amount = 5, direction = "left" })
rex.bind("ctrl+b>p", "pane.resize", { amount = 5, direction = "right" })
rex.bind("ctrl+b>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+b>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+b>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+b>l", "pane.focus", { direction = "right" })
rex.bind("ctrl+b>]", "client.tab.next")
rex.bind("ctrl+b>[", "client.tab.previous")
rex.bind("ctrl+b>f", "pane.split", { direction = "down" })
rex.bind("ctrl+b>d", "pane.split", { direction = "right" })
rex.bind("ctrl+b>e", "client.tab.close")
rex.bind("ctrl+b>w", "pane.close")
rex.bind("ctrl+b>n", "client.tab.new")

-- Ghostty (~/.config/ghostty/config)
rex.bind("cmd+enter", "pane.split", { direction = "auto" })
rex.bind("ctrl+h", "pane.focus", { direction = "left" })
rex.bind("ctrl+j", "pane.focus", { direction = "down" })
rex.bind("ctrl+k", "pane.focus", { direction = "up" })
rex.bind("ctrl+l", "pane.focus", { direction = "right" })

