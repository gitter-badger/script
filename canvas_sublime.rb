#!/usr/bin/ruby -w
# canvas_sublime.rb
# Description: Exploring Sublime Text Editor

## Editing
Ctrl + Shift + D ## duplicates line/selection
Shift + Alt + Up/Down ## enlarge cursor

## Transposition
Ctrl + Shift + Up/Down ## Move selection up/down

## Selecting
## > select word
## > select line
## > select similar indents
## > select everything within tag

## > Indentention

## Copy/Patse
Ctrl + C ## Copy
Ctrl + V ## Paste
Ctrl + Shift + V ## Paste w/ indentation
Ctrl + Shift + K ## Delete line

## Find/Replace
Ctrl + F ## Find
Ctrl + H ## Replace

## Uppercase/Lowercase
Ctrl KU
Ctrl KL

## Comment
Ctrl + /

## Macro
## > Start/Stop recording
## > Play recording

## > Bookmarks

## Columns
Shift + Alt + <number> ## Set layout columns count
Ctrl + <number> ## Set current target column
Shift + Ctrl + <number> ## Move tab to column

## Layout Focus
F11 ## Set fullscreen
Shift + F11 ## Set distraction free mode
Ctrl + KB ## Show/Hide sidebar

## Search
Ctrl + G ## line search
Ctrl + R ## method search

##
'Ctrl + `'  ## opens the embedded command line
Ctrl + Shift + P ## open command palette

## Procedure:
Command + T ## Find spec
Command + T ## Find implementation

## Increase/Decrease Font Size
Ctrl + -
Ctrl + +

Ctrl + T  ## great for finding and opening files
## NOTE prioritizes files via first letter of a word
Ctrl + T << 'slelsp' ## will find '(s)pec/(l)ib/(el)ement_(sp)ec.rb'
## NOTE supply a line number for greater accuracy
Ctrl + T << 'slelsp: 72' ## will highlight line 72
## NOTE supply a method for greater accuracy
Ctrl + T << 'sleslp@init' ## will highlight the 'initialize' method

Ctrl + Shift + up/down arrow ## extend your cursor to multiple lines
Ctrl + D ## select next instance of current selection
## NOTE these are great for mass edits

## Plugins Install
Command + Shift + P "Package Install" <package>

## > PackageControl
## > SideBarEnhancements
## > Git
## > Gitgutter
## > SASS
## > Better CoffeeScri