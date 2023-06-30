# Kmonad

Of course you need to setup kmonad first.

1. Add user to uinput according to [faq](https://github.com/kmonad/kmonad/blob/master/doc/faq.md#q-how-do-i-get-uinput-permissions) from kmonad.

2. Reboot.

3. Copy service to right path:

```bash
# systemd
cp -i ~/.config/kmonad/kmonad.service ~/.config/systemd/user/
systemctl --user enable kmonad --now
```
