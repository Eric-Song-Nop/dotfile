# Eric's Dotfiles

This is where I put all my important config files.

## Actively used configs

- [nvim](https://neovim.io)
- [lvim](https://www.lunarvim.org), I use my own nvim config now.
- [gitui](https://github.com/extrawurst/gitui)
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [zim](https://zimfw.sh/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

- [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
  - My common used clang-tidy is extracted from Clion and put in `.config/lvim/lua/user`.
- [clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
  - My common used clang-format is put in $HOME directory.

## Other useful tools


## Less active

- [awesome wm](https://awesomewm.org)
- [kmonad](https://github.com/kmonad/kmonad/)
- [BetterDiscord](https://betterdiscord.app/themes)
- [zellij](https://zellij.dev)
- [ranger](https://ranger.github.io)

## Usage

### Adaptive color for kitty

```bash

## Add to $HOME/.config/ags/scripts/color_generation/colorgen.sh
apply_kitty() {
    # Check if scripts/templates/kitty/kitty.ini exists
    if [ ! -f "scripts/templates/kitty/kitty_color.conf" ]; then
        echo "Template file not found for Kitty. Skipping that."
        return
    fi
    # Copy template
    cp "scripts/templates/kitty/kitty_color.conf" "$HOME/.config/kitty/kitty_color_new.conf"
    # Apply colors
    for i in "${!colorlist[@]}"; do
        sed -i "s/${colorlist[$i]} #/${colorvalues[$i]}/g" "$HOME/.config/kitty/kitty_color_new.conf" # note: ff because theyre opaque
    done
    cp "$HOME/.config/kitty/kitty_color_new.conf" "$HOME/.config/kitty/kitty_color.conf"
}

apply_kitty
```

### Lunarvim

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

### ZSH

```bash
# append to zshrc
eval "$(starship init zsh)"
```
