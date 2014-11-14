SCRIPT

summary...
==============

Collaborative Setup
--------------

Fork repository to your own GitHub account.

```
git clone https://github.com/<user>/script.git
git remote add upstream https://github.com/wurde/script.git
```

To share your code, simply open a pull request.

Typical Workflow
--------------

```
script --list git

#=> github2irc.rb     Github IRC Gateway
#=> gitcommit.rb      Simple bundling of commands to execute a git commit
```

This command matches against all names containing 'git'. Often I use this before
calling a --fetch to find a specific script I know exists but can't quite remember
what I called it.

```
script --fetch gitcommit regexp
```

With the select canvases now available on the Desktop I proceed to open all
in my text editor of choice Sublime. When done, I clean off the Desktop adding a
summary commit message for any changes made.

```
script --clean
```

```
script --history
```

The history option prints a canvas list of added, modified, and deleted
within the last 7 days.

```
script --new
script --refresh
source ~/.bashrc
```

Complete Options
--------------

USAGE: script [options] [SCRIPT]
    -l, --list [REGXP]               List all matching scripts
    -n, --new SCRIPT                 Create a script
    -f, --fetch                      Copy script(s) to Desktop
        --info SCRIPT                Show script information
        --clean                      Move script(s) off Desktop
        --refresh                    Refresh script Bash aliases
        --history                    List recent script activity
