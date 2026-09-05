# ~/nix-darwin/home/zsh.nix
{ config, lib, pkgs, ... }:

let
  omz = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  ezaTreeExcl = "--git-ignore";
  # ezaTreeExcl = "--git-ignore --ignore-glob=.git\\|node_modules\\|.cache\\|target\\|dist";
in
{
  ### ── Packages that were previously "if installed" ─────────────────
  # zsh-completions installs into share/zsh/site-functions, which HM adds
  # to $fpath before compinit — no zinit/blockf dance needed.
  home.packages = with pkgs; [
    zsh-completions
    fnm
    pnpm
  ];

  ### ── CLI programs managed by Home Manager ─────────────────────────
  programs.bat.enable = true;
  programs.btop.enable = true;

  programs.bun = {
    enable = true;
    enableGitIntegration = false;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    # Keep the custom aliases below instead of HM's default aliases.
    enableZshIntegration = false;
  };

  programs.fd.enable = true;
  programs.go.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.ripgrep.enable = true;
  programs.uv.enable = true;

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    attachExistingSession = false;
    exitShellOnExit = false;
  };

  ### ── Env + PATH (was: export BUN_INSTALL/PNPM_HOME, path+=…) ──────
  home.sessionVariables = {
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  # Appended entries (HM appends these to PATH in hm-session-vars.sh)
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  ### ── Shell integrations (replace the eval "$(… init zsh)" lines) ──
  programs.fzf = {
    enable = true;
    enableZshIntegration = true; # eval "$(fzf --zsh)"  (HM order 910)
    defaultOptions = [ "--height 40%" "--layout=reverse" "--border" "--info=inline" ];
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidget.command = config.programs.fzf.defaultCommand; # FZF_CTRL_T_COMMAND
    # older home-manager: fileWidgetCommand = config.programs.fzf.defaultCommand;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ]; # replaces `alias cd=z`, gives `cdi`
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = "${config.xdg.configHome}/ohmyposh/custom-atomicBit.toml";
  };

  ### ── Zsh ───────────────────────────────────────────────────────────
  programs.zsh = {
    enable = true;
    autocd = true;

    # ── compinit (synchronous, 24h cache) ──
    # HM runs this at order 570, after $fpath is populated (zsh-completions,
    # plugin dirs). Still required before bun/uv/uvx completions (compdef).
    enableCompletion = true;
    completionInit = ''
      autoload -Uz compinit
      _zcd="''${ZDOTDIR:-$HOME}/.zcompdump"
      # Full rebuild if dump is missing OR older than 24h; instant -C otherwise.
      # -u avoids Homebrew "insecure directories" prompts.
      if [[ ! -f $_zcd || -n $_zcd(#qN.mh+24) ]]; then
        compinit -u -d "$_zcd"
      else
        compinit -C -d "$_zcd"
      fi
      unset _zcd
    '';

    # ── Plugins (zinit replacements) ──
    autosuggestion = {
      enable = true;                              # sourced at order 700
      strategy = [ "history" "completion" ];      # ZSH_AUTOSUGGEST_STRATEGY
    };

    fastSyntaxHighlighting.enable = true;         # sourced at order 1200
    # If your home-manager is too old for this option, use instead:
    # plugins = [{ name = "fast-syntax-highlighting";
    #   src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting"; }];

    historySubstringSearch.enable = true;         # sourced at order 1250,
                                                  # binds ^[[A / ^[[B by default

    # OMZP::git / sudo / extract / copypath — sourced directly from the
    # oh-my-zsh package (order 900), no OMZ framework or second compinit.
    # lib/git.zsh + lib/clipboard.zsh are the helpers git/copypath depend on
    # (zinit's OMZP:: snippets never loaded them — drop if you don't want them).
    plugins = [
      { name = "omz-lib-git";       src = "${omz}/lib"; file = "git.zsh"; }
      { name = "omz-lib-clipboard"; src = "${omz}/lib"; file = "clipboard.zsh"; }
      { name = "git";      src = "${omz}/plugins/git"; }
      { name = "sudo";     src = "${omz}/plugins/sudo"; }
      { name = "extract";  src = "${omz}/plugins/extract"; }   # _extract → fpath
      { name = "copypath"; src = "${omz}/plugins/copypath"; }
    ];

    # Defined at the top of .zshrc (order 540), before plugins are sourced
    localVariables = {
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = "20";
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = "1";
    };

    # ── History ──
    history = {
      size = 50000;
      save = 50000;
      path = "${config.home.homeDirectory}/.zsh_history";
      share = true;                 # sharehistory
      ignoreSpace = true;           # hist_ignore_space
      ignoreAllDups = true;         # hist_ignore_all_dups
      saveNoDups = true;            # hist_save_no_dups
      findNoDups = true;            # hist_find_no_dups
      expireDuplicatesFirst = true; # hist_expire_dups_first
      extended = true;              # extended_history
    };

    # ── setopts not covered by history/autocd ──
    setOptions = [
      "HIST_REDUCE_BLANKS"
      "HIST_VERIFY"
      "INTERACTIVE_COMMENTS"
      "EXTENDED_GLOB"
      "NO_BEEP"
      "AUTO_PUSHD"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_MINUS"
    ];

    # ── Aliases ──
    # eza/bat/rg/fd/btop are guaranteed by Home Manager program modules, so the
    # "(( $+commands[...] ))" guards and the per-OS ls fallback are gone.
    shellAliases = {
      ls   = "eza --icons --group-directories-first";
      ll   = "eza -l --icons --git --group-directories-first";
      la   = "eza -la --icons --git --group-directories-first";
      lt   = "eza --tree --icons --level=2 ${ezaTreeExcl}";
      lat  = "eza -a --tree --icons --level=2 ${ezaTreeExcl}";
      ltt  = "eza --tree --icons --level=3 ${ezaTreeExcl}";
      latt = "eza -a --tree --icons --level=3 ${ezaTreeExcl}";

      cat  = "bat --paging=never";
      grep = "rg";
      find = "fd";
      top  = "btop";

      zshrc  = "$EDITOR ~/nix-darwin/home/zsh.nix";
      reload = "exec zsh";
      path   = "print -l $path";
      d      = "dirs -v";
    };

    # ── Everything else, ordered ──
    initContent = lib.mkMerge [

      # 500: early init — prepends, editor, and things compinit needs.
      (lib.mkOrder 500 ''
        # Prepend so they win over system copies (HM runs typeset -U right after).
        # NOTE: pnpm puts binaries directly in $PNPM_HOME — no /bin subdir.
        path=("$BUN_INSTALL/bin" "$HOME/.kimi-code/bin" $path)
        [[ -d $PNPM_HOME ]] && path=("$PNPM_HOME" $path)

        # The (#q…) glob qualifier in completionInit needs EXTENDED_GLOB
        # *before* compinit; HM's setOptions only run afterwards (950).
        setopt extended_glob
        zmodload zsh/terminfo
      '')

      # 600: fzf-tab — must be after compinit (570) but before widget-wrapping
      # plugins like autosuggestions (700). Can't go through `plugins` (900).
      # fzf's own integration loads later (910) and falls back to fzf-tab's
      # widget for plain <Tab>, so both `**<Tab>` and fzf-tab keep working.
      (lib.mkOrder 600 ''
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      '')

      # 1000: general config
      (lib.mkOrder 1000 ''
        ### ── Keybindings ──
        # Ctrl+Left/Right — jump to previous/next word
        bindkey "''${terminfo[kLFT5]:-^[[1;5D}" backward-word
        bindkey "''${terminfo[kRIT5]:-^[[1;5C}" forward-word
        bindkey "''${terminfo[khome]:-^[[H}"   beginning-of-line   # Home
        bindkey "''${terminfo[kend]:-^[[F}"    end-of-line         # End
        bindkey "''${terminfo[kdch1]:-^[[3~}"  delete-char         # Delete

        # Edit command line in $EDITOR (Ctrl-X Ctrl-E)
        autoload -Uz edit-command-line; zle -N edit-command-line
        bindkey '^X^E' edit-command-line
        # bindkey -M vicmd v edit-command-line

        # bash-style word boundaries: Ctrl-w / Alt-b / Alt-f stop at / and .
        autoload -Uz select-word-style && select-word-style bash

        ### ── Completion styling ──
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/.zcompcache"
        # case-insensitive first, then partial-word fallback
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no                     # let fzf-tab own the menu
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*:descriptions' format '[%d]'  # plain text — fzf-tab requirement
        zstyle ':completion:*:warnings'     format '── no matches ──'
        zstyle ':fzf-tab:*' switch-group '<' '>'
        zstyle ':fzf-tab:complete:cd:*' fzf-preview \
          'eza -1 --color=always --icons $realpath 2>/dev/null || ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
          'eza -1 --color=always --icons $realpath 2>/dev/null || ls --color $realpath'

        # fnm: --shell skips process-tree detection; recursive = find
        # .nvmrc/.node-version in parent dirs; quiet = no banner on cd.
        # The Nix package supplies fnm's completion definition.
        if (( $+commands[fnm] )); then
          eval "$(fnm env --use-on-cd --shell zsh --version-file-strategy=recursive --log-level=quiet)"
        fi
      '')
    ];
  };
}
