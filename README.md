# Welcome to Script <br/><small>we are command-line applications.</small>

[![Join the chat at https://gitter.im/wurde/script](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/wurde/script?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Stories in Ready](https://badge.waffle.io/wurde/script.svg?label=ready&title=Ready)](http://waffle.io/wurde/script)

Script is a collaborative repository dedicated to command-line applications of various languages. Leverage the growing list of applications or develop your own as a fun way to learn a language and automate repetitive tasks.

## TODO

+ canvas.rb  (project) Add support for Go language
+ translate_yaml.rb (comm) Bug Fixes
  * handler for YAML Arrays
  * handler for interpolated data
+ narrativeclip.rb (project) Flush pictures off Narrative Clip
+ pomodoro.rb (project) randomize around directories/roadtrips if exist
+ offline-wikipedia.rb (search) Setup a local mirror of wikipedia

## Usage

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

## 3rd Party API Spotlight

+ [GitHub](https://developer.github.com)
+ [AngelList](https://angel.co/api)
+ [StackExchange](http://api.stackexchange.com/docs)
+ [LinkedIn](https://developer.linkedin.com)
+ [Slack](https://api.slack.com)


## Contribute to the Source

We encourage contributions from the open source community! Check out our wiki on [how to proceed](https://github.com/wurde/script/wiki/Contributing) or [fork it now](https://github.com/wurde/script/fork).

A [code of conduct](https://github.com/wurde/script/blob/master/CODE_OF_CONDUCT.md) protects all community members.

## License
Script is released under the [MIT License](http://www.opensource.org/licenses/MIT).
