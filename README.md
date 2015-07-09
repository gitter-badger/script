Script <br/><small>our mission is command-line applications.</small>
--------------
Script is a collaborative repository dedicated to command-line applications of various languages. Also it serves as a fun way to learn a language or automate repetitive tasks.

Current Favorites
--------------

+ enforce-80char.rb (admin) enforce 80 character limit per line
+ gitcommit.rb (project) Simple bundling of commands to execute a git commit
+ asciitrails.rb (fun) Walk the ASCII trails
+ babelfish.rb (comm) Remove language boundaries

Usage
--------------

```
script --list git
script -l git

#=> github2irc.rb     Github IRC Gateway
#=> gitcommit.rb      Simple bundling of commands to execute a git commit
... etc

# The default extension is .rb for Ruby, override for other languages.
script --fetch gitcommit regexp portscan.py

# Once you're done or want to save, call clean to commit changes.
script --clean

# Often a script doesn't exist yet, so just add it and update ~/.bashrc
script --new bootable-usb.exp
script --refresh
source ~/.bashrc
```

Contribute
--------------

This project begs to be forked. [(please please please)](https://github.com/wurde/script/fork)<br/>
All contributions returned will be attributed and preserved.
