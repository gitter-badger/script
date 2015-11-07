Welcome to Script <br/><small>we are command-line applications.</small>
--------------
Script is a collaborative repository dedicated to command-line applications of various languages. Leverage the growing list of applications or develop your own as a fun way to learn a language and automate repetitive tasks.

TODO
--------------

+ canvas.rb  (project) Add support for Go language
+ translate_yaml.rb (comm) Bug Fixes
  * handler for YAML Arrays
  * handler for interpolated data
+ narrativeclip.rb (project) Flush pictures off Narrative Clip
+ pomodoro.rb (project) randomize around directories/roadtrips if exist
+ offline-wikipedia.rb (search) Setup a local mirror of wikipedia

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

3rd Party API Spotlight
--------------

+ [GitHub](https://developer.github.com)
+ [AngelList](https://angel.co/api)
+ [StackExchange](http://api.stackexchange.com/docs)
+ [LinkedIn](https://developer.linkedin.com)
+ [Slack](https://api.slack.com)


Contribute
--------------

This project begs to be forked. [(please please please)](https://github.com/wurde/script/fork)<br/>
All contributions will be attributed and preserved.

License
--------------
Script is released under the [MIT License](http://www.opensource.org/licenses/MIT).
