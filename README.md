# dotfiles

These are my dotfiles.  A way to keep them organized and in sync across multiple computers.

The idea is to clone the repo in a normal place and the symbolically link the
files that you want to use into your home directory:

```bash
ln -s ~/src/tm/Erik.Tank/dotfiles/.bash_profile_git ~/
```

## Why all the files????

Since I work on several different computers with varying software I've found it easier to seperate the file into categories.  This way I can only link the files that apply to the specific computer that I'm working on.

Some compromises are still made.  For instance: you can only have one .gitconfig file so I need to chose one environment to use and remember that for other computers.

I've also taken pains to streamline the loading.  Some processes take longer than most so they are not automatically loaded.  One such case is setting up NVM for NodeJs.  I don't use it all the time; therefore, having to run setup_nvm when it is needed is preferable to having each terminal load take an extra second.

## Requirements

In your main .bashrc, .bash_profile, etc file you need to have the following to
include other profiles:

```bash
# load specific/special bash profile files if they are present
for f in ~/.bash_profile_*
do
    if [[ $f =~ \.sw.$ ]]
    then
        continue
    else
        source $f
    fi
done
```
