# nix-darwin

A Nix flake that configures one Apple Silicon Mac with
[nix-darwin](https://github.com/nix-darwin/nix-darwin) (system settings,
Homebrew through `nix-homebrew`) and
[Home Manager](https://github.com/nix-community/home-manager) (shell and tools).
It is built for the author's machine; the repo is public but not meant to be
forked.

## Layout

```text
flake.nix          inputs; constants `system` and `repoPath`; builds the one host
user-config.nix    the author's values: user, host, full name, Git identity, SSH key names
packages.nix       THE package file: every tool and app is named here (see Placement rule)
darwin/            system side (nix-darwin)
home/              user side (Home Manager)
```

`flake.nix` builds `darwinConfigurations.<hostname>` from `./darwin` and passes
`inputs`, `self`, `userConfig`, `system`, `repoPath` and `packagesFile` to the
system modules and, through `extraSpecialArgs`, to Home Manager. No file is
named after the host.

Values that sit outside `user-config.nix`, on purpose: `system`
(`aarch64-darwin`) and `repoPath` (the home directory plus `/nix-darwin`) in
`flake.nix`, and the `~/.ssh/` prefix in `home/ssh`. The checkout must live at
`~/nix-darwin`: `repoPath` feeds the Neovim link, and the `zshrc` alias finds
the repo through that link.

## Rebuild

Build without switching (writes nothing into the repo; never run
`darwin-rebuild build` here, it creates `./result`):

```bash
nix build --no-link .#darwinConfigurations.<hostname>.system
```

Switch, from Terminal.app (not from Ghostty or a zellij pane, because a switch
that touches Ghostty can end the session that runs it):

```bash
sudo darwin-rebuild switch --flake ~/nix-darwin#<hostname>
```

`<hostname>` is `hostname` in `user-config.nix`. Flakes only see files that git
tracks: `git add -N <new file>` before building.

## Placement rule

Written at the top of [packages.nix](packages.nix):

- a tool with no Home Manager module in this repo goes to `system`;
- a tool that has a Home Manager module goes to `homeTools` (switched on as
  `programs.<name>.enable`; settings stay in `home/programs.nix` and `home/<tool>/`);
- a GUI app goes to `homebrew.casks`;
- a font goes to `fonts`;
- a command-line tool that cannot be substituted from the Nix cache goes to
  `homebrew.brews`, so nothing is compiled on the machine.

## Author-only steps

Agents build and compare; they never switch, push or uninstall. These are done
by hand:

1. Check Guest login: `defaults read /Library/Preferences/com.apple.loginwindow GuestEnabled`
   prints `0`.
2. `homebrew.cleanup` is `"uninstall"`: a formula, cask or tap that
   `packages.nix` does not declare is removed on the next switch, so declare it
   there first.
