{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.zsh
    pkgs.nixd
    pkgs.bottom
    # pkgs.taffybar
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sam/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # git
  programs.git = {
    enable = true;
    userName = "Sam Tay";
    userEmail = "samctay@pm.me";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSOyLI6M+OWZsE10mkZMcbnQ1a/wnjPgX1eNHJ6iYYo";
      signByDefault = true;
    };
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        # program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        program = "/opt/1Password/op-ssh-sign";
      };
      branch = {
        autosetuprebase = "always";
        rebase = true;
      };
      advice = {
        detachedHead = false;
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
    attributes = ["*.pdf diff=pdf"];
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "gruvbox-light";
        whitespace-error-style = "22 reverse"; # ?
      };
    };
    aliases = {
      # List commits in short form, with colors and branch/tag annotations
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate";

      # List commits showing changes files
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat";

      # List oneline commits showing dates
      lds = "log --pretty=format:\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=short";

      # List oneline commits showing relative dates
      ld = "log --pretty=format:\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=relative";

      # Basic oneline
      le = "log --oneline --decorate";

      # Better git log
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      # Display a log tree
      logtree = "log --graph --oneline --decorate --all";

      # Show repository contributers
      who = "shortlog -n -s --no-merges";

      # Information about the current commit
      whatis = "show -s --pretty='tformat:%h (%s, %ad)' --date=short";

      # See all commits related to a file
      filelog = "log -u";
      fl = "log -u";

      # Concise commits related to file
      follow = "log --follow --stat";

      # Show modified files in last commit
      dl = "\"!git ll -1\"";

      # Show a diff of the last commit
      dlc = "show HEAD^";

      # Show content (full diff) of a commit given a revision
      dr  = "\"!f() { git diff \"$1\"^..\"$1\"; }; f\"";
      lc  = "\"!f() { git ll \"$1\"^..\"$1\"; }; f\"";
      diffr  = "\"!f() { git diff \"$1\"^..\"$1\"; }; f\"";

      # Find a file path in codebase
      f = "\"!git ls-files | grep -i\"";

      # Search/grep your entire codebase for a string
      grep = "grep -Ii";
      gr = "grep -Ii";

      # Grep from root folder
      gra = "\"!f() { A=$(pwd) && TOPLEVEL=$(git rev-parse --show-toplevel) && cd $TOPLEVEL && git grep --full-name -In $1 | xargs -I{} echo $TOPLEVEL/{} && cd $A; }; f\"";

      # Output your aliases
      la = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";

      # Assume a file as unchanged
      assume = "update-index --assume-unchanged";

      # Unassume a file
      unassume = "update-index --no-assume-unchanged";

      # Show assumed files
      assumed = "\"!git ls-files -v | grep ^h | cut -c 3-\"";

      # Unassume all assumed files
      unassumeall = "\"!git assumed | xargs git update-index --no-assume-unchanged\"";

      # Assume all
      assumeall = "\"!git st -s | awk {'print $2'} | xargs git assume\"";

      # Show the last tag
      lasttag = "describe --tags --abbrev=0";
      lt = "describe --tags --abbrev=0";

      # Shows a list of files that have a merge conflict
      conflicts = "diff --name-only --diff-filter=U";

      # Unstages a file. Use like 'git unstage filename'
      unstage = "reset HEAD --";

      # Resets all uncomitted changes and files
      abort = "reset --hard HEAD";

      # Undo last commit
      undo = "reset HEAD~1";

      # Change last commit message
      recommit = "commit --amend";

      # Get the current branch name (not so useful in itself, but used in
      # other aliases)
      branch-name = "\"!git rev-parse --abbrev-ref HEAD\"";

      # List all commits that have not been pushed to origin
      unpushed = "log --branches --not --remotes --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      # See what's new since the last command
      new = "!sh -c 'git log $1@{1}..$1@{0} \"$@\"'";

      # Completely delete a branch (local and origin)
      rmb = "!sh -c 'git branch -D $1 && git push origin $1 --delete' -";

      # Merging
      ours = "\"!f() { git co --ours $@ && git add $@; }; f\"";
      theirs = "\"!f() { git co --theirs $@ && git add $@; }; f\"";

      # Basic shortcuts
      cp = "cherry-pick";
      st = "status -s";
      cl = "clone";
      ci = "commit";
      co = "checkout";
      br = "branch";
      diff = "diff --word-diff";
      dc = "diff --cached";

      # Reset commands
      r = "reset";
      r1 = "reset HEAD^";
      r2 = "reset HEAD^^";
      rh = "reset --hard";
      rh1 = "reset HEAD^ --hard";
      rh2 = "reset HEAD^^ --hard";

      # Stash operations
      sl = "stash list";
      sa = "stash apply";
      pop = "stash pop";
      ss = "stash save";
    };
  };

  # zsh
  programs.zsh.enable = true;
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./zsh/zshrc;

  # xmonad
  xsession = {
    # currently have sddm configured
    # enable = true;
    windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
    };
  };
  xdg.configFile."xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;

  # taffybar
  services.taffybar.enable = true;
  xdg.configFile."taffybar/taffybar.hs".source = ./taffybar/taffybar.hs;
  xdg.configFile."taffybar/taffybar.css".source = ./taffybar/gruvbox-light.css;

  # kitty
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty/kitty.conf;
    themeFile = "GruvboxMaterialLightMedium";
  };

  # neovim
  programs.neovim.enable = true;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
}
