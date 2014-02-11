#!/usr/bin/expect
# package_expect.sh
# Description: Exploring the 'expect' command-line application.

## Q: how to execute 'system' command and 'expect' commands
## a: using 'spawn'
#proc t5 {} {
#    send "ls > /home/wurde/Desktop/test-expect_output.txt\r"
#    send "hello\n"
#}

## NOTE best way to build
## use 'exp_internal 1' to get output
## use 'interact' until your patterns match

## READ command-line arguments
#[lindex $argv 0]
#[lindex $argv 1]

## CREATE application process with 'spawn'
#set PASSWORD "trichoderma"
#set PACKAGE "blackbox"
#send "installing package(s): $PACKAGE...\n"
#exp_internal 1
#spawn sudo apt-get install $PACKAGE
#expect "\[sudo\]*" { send "$PASSWORD\r" }
#expect "\[Y/n\]*" { send "Y\r"}
#interact

## READ expect internal messages
## great for debugging pattern matching
#spawn ssh www.accreu.com
#exp_internal 1
#expect "Login: "

## CREATE a procedure
#proc domainname {} {
#  set file [open /etc/resolv.conf r]
#  while {[gets $file buf] != -1} {
#    if {[scan $buf "domain %s" name] == 1} {
#      close $file
#      return $name
#    }
#  }
#}
#send "$env(USER)@[domainname].com\r"

## READ environment variables
#send "$env(USER)@blah.com\r"
#=>wurde@blah.com

## NOTE: expect command 'times out' after a default of 10 seconds
## to change this 'set timeout <SECONDS>'
#set timeout 60

## DISABLE timeout
#set timeout -1
#expect "testing" {
#  send "1 2 3\n"
#}

## CREATE carriage-return linefeed sequence
#send "\r\n"

## READ answers after CREATE process
#spawn ftp ftp.uu.net
# the '\r' is for 'return' keypress
#expect "Name"
#send "anonymous\r"
#expect "Password:"
#send "foo@sicle.com\r"
#expect "ftp> "

## CREATE a process
## using the 'spawn' command
#spawn ftp ftp.uu.net

## SET timeout from command-line argument
## Output characters in buffer at first 'return' OR after timeout
#set timeout $argv
#expect "\n" {
#  send [string trimright "$expect_out(buffer)" "\n"]
#}

## CREATE pattern-action pairs that match simultaneously
#expect "ing" { send "3\n" } "test" { send "1\n" } "testing" { send "2\n" }
# ~OR~
#expect "ing" { send "3\n" } \
#  "test" { send "1\n" } \
#  "testing" { send "2\n" }
# ~OR~
#expect {
#  "ing" { send "3\n" }
#  "test" { send "1\n" }
#  "testing" { send "2\n" }
#}

## CREATE pattern-action pairs
## a command is only executed if the pattern is matched
#expect "testing" { send "1 2 3\n" }

## NOTE: expect 'buffers' its' input
## this allows for handling herky jerky outputs cleanly
#expect "hi"
#send "$expect_out(0,string) $expect_out(buffer)"
#=>philosophic
#=>hi phi

## NOTE: expect matches a pattern wherever it is found, unless 'anchored'
## anchors are either '^' caret or '$' dollar sign
# expect "^cat"
# send "this is not a tacocat."
#=>tacocat
#=>cat
#=>this is not a tacocat.wurde@base:~/Desktop$

## NOTE: immediately following an 'expect' match
## match characters are stored in a variable called 'expect_out(0,string)'
## NOTE: all preceding characters matching or not matching
## are stored in a variable called 'expect_out(buffer)'
#expect "testing\n"
#send "you typed <$expect_out(buffer)>\n"
#send "but I only expected <$expect_out(0,string)>\n"
#=>what testing
#=>you typed <what testing
#=>>
 #=>but I only expected <testing
#=>>

## READ 'testing' WRITE '1 2 3'
#expect "testing\n"
#send "1 2 3\n"
#=>testing
#=>1 2 3

## WRITE 'testing 1 2 3'
#send "testing 1 2 3\n"
#=>testing 1 2 3
#=>wurde@base:~/Desktop$

## WRITE 'testing 1 2 3'
#send "testing 1 2 3"
#=>testing 1 2 3wurde@base:~/Desktop$