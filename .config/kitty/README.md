# Kitty manual

## Configure Color Scheme

```bash

git clone --depth=1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes/
cd ~/.config/kitty
ln -s ./kitty-themes/themes/gruvbox_dark.conf ~/.config/kitty/theme.conf

```

Then add "include ./theme.conf" to the buttom of kitty.conf.

## Important Key mappings

### Tab

| Key              | Usage                     |
|------------------|---------------------------|
| k_mod            | <C-Shift>                 |
| k_mod+t          | new tab                   |
| k_mod+left/right | last/next tab             |
| k_mod+q          | close tab                 |
| k_mod+./,        | move_tab_forward/backward |

### Other

| Key         | Usage                        |
| k_mod+F11   | Full screen                  |
| k_mod+u     | Unicode input                |
| k_mod+enter | New window                   |
| k_mod+l     | Change window layout         |
| k_mod+w     | Close window                 |
| k_mod+]/[   | Next/Previous window         |
| k_mod+f/b   | Move window forward/backward |
| k_mod+`     | Move window to top           |
| k_mod+num   | Numth window                 |

