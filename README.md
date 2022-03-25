# Configuration for home-manager

## Setup

Copy the repo to `~/.config/nixpkgs` with:

```
GIT_SSH_COMMAND='ssh -i ~/.ssh/<key> -o IdentitiesOnly=yes' git clone git@github.com:kototama/.emacs.d.git ~/.config/nixpkgs
```

Then setup the specific host configuration of the machine:
```
cd .config/nixpkgs
git config --add --local core.sshCommand 'ssh -i ~/.ssh/<sshkey>'
cd hosts
ln -s <host>/config.nix default.nix
```

## Inspirations

- https://github.com/bobvanderlinden/nix-home/
- https://gitlab.com/NobbZ/nix-home-manager-dotfiles/
