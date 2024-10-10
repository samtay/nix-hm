# nix-hm

nix home manager conf

# install

Install nix and home-manager. Then

```
ln -s "$(pwd)/home.nix" ~/.config/home-manager/home.nix
```

and `home-manager switch`. (Maybe can use `nh` after going to flakes.)

# todo

- keep ~/.scripts in here
- but toggle-theme functionality can probably happen within hm
- programs

  - neovim
  - astronvim
  - - bash-langauge-server? shellcheck-bin necessary?
  - zsh
  - pure prompt (or try new one)
  - tmux
  - .scripts/ from dotfiles
  - fzf
  - git
  - rofi
  - systemd lowbat unit
  - qmk.ini
  - kitty cfg
  - discord + settings.json
  - obsidian
  - dunstrc
  - feh
  - background image
  - .config/autostart/ cfg for polkit
  - polkit + polkit-kde-agent (for arch specific stuff, should split home.nix into common.nix and arch.nix)
  - 1pw
  - firefox
  - light
  - spotify
  - zoom?
  - just
  - tldr
  - zathura
  - texlive
  - rust? or rustup
  - clipmenu/clipnotify?
  - dunst?
  - fprintd?
  - ledger?
  - pavucontrol?
  - pipewire?
  - ripgrep
  - sddm?

- what's up with mynixos.com? perhaps useful
