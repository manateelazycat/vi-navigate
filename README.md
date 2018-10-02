# What is it?

Navigate read-only buffer like vi behavior.

I like Emacs' default keystroke, which is easy to use.
I prefer use vi style keystroke if current buffer is read-only
that we can quickly navigated with one key press.

### Installation
Then put vi-navigate.el to your load-path.

The load-path is usually ~/elisp/.

It's set in your ~/.emacs like this:

```Elisp
(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'vi-navigate)
(vi-navigate-load-keys)
```

### Usage
```vi-navigate-hook-list``` value is

```
'(eww-mode-hook
    help-mode-hook
    package-menu-mode-hook
    top-mode-hook
    benchmark-init/tabulated-mode-hook
    benchmark-init/tree-mode-hook
    emms-playlist-mode-hook
    emms-browser-mode-hook
    emms-stream-mode-hook
    apt-utils-mode-hook
    man-mode-hook
    apropos-mode-hook
    less-minor-mode-hook
    info-mode-hook
    doc-view-mode-hook
    w3m-mode-hook
    pdf-view-mode-hook
    irfc-mode-hook
    )
```

vi-navigate will load automatically when you load buffer match above hooks.

| Key       | Description                                                  |
| :-------- | :----                                                        |
| j         | next line                                                    |
| k         | previous line                                                |
| h         | backward char                                                |
| l         | forward char                                                 |
| J         | scroll up one line                                           |
| K         | scroll down one line                                         |
| H         | backward word                                                |
| L         | forward word                                                 |
| e         | scroll down                                                  |
| SPC       | scroll up                                                    |
| y         | Poup translation around cursor (need you install sdcv first) |
| Y         | Show translation around cursor (need you install sdcv first) |
| i         | Poup translation of input      (need you install sdcv first) |
| I         | Show translation of input      (need you install sdcv first) |
| f         | Forward help page              (only works in help buffer)   |
| b         | Backward help page             (only works in help buffer)   |
| TAB       | Next button                    (only works in help buffer)   |
