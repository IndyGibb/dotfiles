# ~/.config/qutebrowser/config.py

# Load settings made via :set / : bind so they persist
config.load_autoconfig()

# --- Catppuccin Mocha theme ---
import catppuccin

# third arg = "plain look" for menu rows; True = flatter look
catppuccin.setup(c, "mocha", True)

# --- Fonts: DepartureMono Nerd Font, sizes on the 11px grid ---
c.fonts.default_family = "DepartureMono Nerd Font"
c.fonts.default_size = "11pt"
# bump specific UI areas if you want them larger, all multiples of 11
c.fonts.completion.entry = "11pt DepartureMono Nerd Font"
c.fonts.statusbar = "11pt DepartureMono Nerd Font"
c.fonts.hints = "11pt DepartureMono Nerd Font"

# --- search engines ---
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "gh": "https://github.com/search?q={}&type=repositories",
    "w": "https://en.wikipedia.org/wiki/{}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "gw": "https://wiki.gentoo.org/index.php?search={}",
}

# --- Behavior quality-of-life
c.downloads.location.directory = "~/downloads"
c.downloads.location.prompt = False
c.tabs.show = "multiple"  # Hide tab bar when only one tab
c.scrolling.smooth = True
c.auto_save.session = True  # restore tabs on restart
c.completion.shrink = True  # completion box only as big as needed

# --- Dark-mode web pages (optional; comment out if you dislike it) ---
c.colors.webpage.darkmode.enabled = True  # set True to force-dark all sites
c.colors.webpage.preferred_color_scheme = "dark"  # respect site dark themes
