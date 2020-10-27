# Configuration for home-manager

## Setup

Copy the repo to `~/.config/nixpkgs` with:

```
git clone <repo> ~/.config/nixpgs
```

Then setup the specific host configuration of the machine:
```
cd hosts
ln -s <host.nix> default.nix
```

## Inspirations

- https://github.com/bobvanderlinden/nix-home/
- https://gitlab.com/NobbZ/nix-home-manager-dotfiles/
