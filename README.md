# Configuration for home-manager

## Setup

Copy the repo to `~/.config/nixpkgs` with:

```
git clone git@github.com:kototama/.emacs.d.git ~/.config/nixpkgs
```

Then setup the specific host configuration of the machine:
```
cd .config/nixpkgs/hosts
cp ci.nix <host.nix>
ln -s <host.nix> default.nix
```

## Inspirations

- https://github.com/bobvanderlinden/nix-home/
- https://gitlab.com/NobbZ/nix-home-manager-dotfiles/
