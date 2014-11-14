Script
--------------
Script is a collaborative repository dedicated to command-line applications of various languages.

Setup for Collaboration
--------------

1. Fork this repository to your GitHub account.

    [Fork this Repo](https://github.com/wurde/script/fork)

2. At the command prompt, clone your forked repository locally.

        git clone https://github.com/<user>/script.git

    Where "user" is your GitHub username.

3. Add an upstream remote link to this repository.

        git remote add upstream https://github.com/wurde/script.git

4. Have fun. To share your code, simply open a pull request.

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
script --history
```

The history option prints a canvas list of added, modified, and deleted
within the last 7 days.

```
script --new
script --refresh
source ~/.bashrc
```

All Available Options
--------------

```
USAGE: script [options] [SCRIPT]
    -l, --list [REGXP]               List all matching scripts
    -n, --new SCRIPT                 Create a script
    -f, --fetch                      Copy script(s) to Desktop
        --info SCRIPT                Show script information
        --clean                      Move script(s) off Desktop
        --refresh                    Refresh script Bash aliases
        --history                    List recent script activity
```
