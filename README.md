Script
--------------
Script is a collaborative repository dedicated to command-line applications of various languages.

Setup for Collaboration
--------------

1. Fork this repository to your GitHub account:

    [Getting Started (click me)](https://github.com/wurde/script/fork)

2. At the command prompt, clone your forked repository locally:

        git clone https://github.com/<user>/script.git

    Where "user" is your GitHub username.

3. Add an upstream remote link to this repository:

        git remote add upstream https://github.com/wurde/script.git

4. Have fun. To share your code, simply open a pull request.

5. At anytime pull in the most recent upstream changes:

        git pull upstream master

Typical Workflow
--------------

Match all script names containing 'git'. Great for getting the exact name before
calling --fetch.

```
script --list git

#=> github2irc.rb     Github IRC Gateway
#=> gitcommit.rb      Simple bundling of commands to execute a git commit
```

Copy specific canvas(es) to the Desktop for easy text editor access. <br/>
File extensions default to ruby (.rb).

```
script --fetch gitcommit regexp
```

When done, I clean off the Desktop and add a commit message that servers as a
summation of changes made within those canvases.

```
script --clean
```

The history option prints a canvas list of added, modified, and deleted
within the last 7 days.

```
script --history
```

Create a new script and automatically add it to ~/.bash_aliases.

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
