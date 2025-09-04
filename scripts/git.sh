#!/usr/bin/env bash
set -x

rm -f $HOME/.gitconfig
echo "
[http]
	proxy = socks5://127.0.0.1:7893
[core]
#   sshCommand = ssh.exe
  pager = less
[user]
  email = arielherself@duck.com
  name = arielherself
[credential]
  helper = store
[diff]
  tool = vimdiff
[merge]
  tool = vimdiff
[user]
  signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3+9t7aTNMzzEBMW7O7WzXlUbIppCEs/TnGxuqrt9bj
[gpg]
  format = ssh
[gpg \"ssh\"]
  program = \"/opt/1Password/op-ssh-sign\"
[log]
  date = human
[format]
  pretty = format:%C(yellow)%h %Cblue%>(12)%ah %Cgreen%<(7)%aN%Cred%d %Creset%s
[alias]
  tree = log --graph --decorate --abbrev-commit
" >| $HOME/.gitconfig

chmod a-w $HOME/.gitconfig
