#!/usr/bin/env ruby -w
# class_optparse.rb
# Description: command-line option parser

require 'optparse'

#############
### rbnew ###
# require 'optparse'

# options = {}
# option_parser = OptionParser.new do |opts|
#   executable_name = File.basename($PROGRAM_NAME, ".rb")
#   opts.banner = "Usage: #{executable_name} [OPTION]... NAME..."

#   ## flag. Is it an app, canvas, script, or template
#   opts.on("-t TYPE", "--type") do |type|
#     ## > fail 'Not a recognized type.'
#     options[:type] = type
#   end
# end.parse!

## > ARGV. Name

## NOTE rbnew provides an interface to creating
## rbapp, rbcanvas, rbscript, and rbtemplate
## Q: handle unique command arguments (e.g. templates for rbapp)

##################
### rblauncher ###
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME, '.rb')
  opts.banner = "Usage: #{executable_name} [OPTION]... PROJECT_DIRECTORY..."

  opts.on('--purge-launcher', 'Indicate removal of previously created launcher') do
    options[:purge_launcher] = true
  end
end.parse!

## >> CHECK ARGV exist. (fail if NOT)
# fail 'Usage: rblauncher --purge-launcher path/to/project|.' unless ARGV.
# target_project = ARGV[0]
# ## >> ARGV. 'path/to/project' ~OR~ '.' current directory
#   ## >>> CHECK directory exist (fail if NOT)
#   fail "Directory does not exist at '#{target_project}'" unless File.exists?(target_project)
#   ## >>> CHEKC project exist (fail if NOT)
#   fail "" unless
## >> ARGV[OPTIONAL]. 'git branch'
  ## >>> CHECK if git exist (fail if NOT)
  ## >>> CHECK if branch exist (fail if NOT)
## >> CHECK option. option[purge_launcher] (TRUE)
  ## >>> CHEKC previous launcher exist (fail if NOT)
  ## >>> remove launcher
## >> CHECK option. option[purge_launcher] (FALSE)
  ## >>> CHEKC previous launcher exist (fail if)
  ## >>> add launcher ~/.rbscript/launcher/
  ## NOTE file follows convention '<project>-<branch>.rb'
  ## NOTE seed file
    # >>>> [gnome-terminal] git branch checkout
    # >>>> [gnome-terminal] start rails server
    # >>>> [sublime] open project directory
    # >>>> [firefox] open to 127.0.0.1:3000
  ## >>> add action to /usr/share/applications/launch_dev.desktop

#############
### NOTES ###

## TIP avoid hardcoding in the name of an application into the usage banner
## To do this simply grab the basename of the executable
## executable_name = File.basename($PROGRAM_NAME)
## opts.banner = "Usage: #{executable_name} [OPTIONS]... ARGUMENT..."

## NOTE that an optional flag
## -f [FLAG]
## implies that the '-f' can standalone without an argument

## NOTE option arguments are defined within brackets '[]'
## EXAMPLE opts.on("-n [NAME]", "--name [NAME]")

## NOTE opts.on differentiates between switches and flags
## If an argument passed contains a dash and no whitespace; switch
## If an argument passed contains a dash and a whitespace; flag
## If multiple option names are given, then they are treated the same.
## Q: how is that implemented if we pass a switch and a flag argument.
## a: fails gracefully
## Q: how does opts.on handle '-xMANDATORY' versus '-x MANDATORY'
## NOTE the whitespace is reserved for defining flags while single
## a: it will use the first as a switch and the second as a flag
## NOTE if an argument for a flag is defined then all other forms of
## that option will require that argument.
## EXAMPLE: opts.on("-t", "--time [TIME]")
## EXAMPLE: opts.on("-u USER", "--sername")

## NOTE flag or argument
## An option is best used as an argument
## when it is the primary object of the command

## Q: how does opts.banner get used
## a: for displaying usage exmaples
## q: yes but, when and how

##########################################
### ri OptionParser (complete) example ###
# require 'optparse'
# require 'optparse/time'
# require 'ostruct'
# require 'pp'

# class OptparseExample

#   CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
#   CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

#   #
#   # Return a structure describing the options.
#   #
#   def self.parse(args)
#     # The options specified on the command line will be collected in *options*.
#     # We set default values here.
#     options = OpenStruct.new
#     options.library = []
#     options.inplace = false
#     options.encoding = "utf8"
#     options.transfer_type = :auto
#     options.verbose = false

#     opt_parser = OptionParser.new do |opts|
#       opts.banner = "Usage: example.rb [options]"

#       opts.separator ""
#       opts.separator "Specific options:"

#       # Mandatory argument.
#       opts.on("-r", "--require LIBRARY",
#               "Require the LIBRARY before executing your script") do |lib|
#         options.library << lib
#       end

#       # Optional argument; multi-line description.
#       opts.on("-i", "--inplace [EXTENSION]",
#               "Edit ARGV files in place",
#               "  (make backup if EXTENSION supplied)") do |ext|
#         options.inplace = true
#         options.extension = ext || ''
#         options.extension.sub!(/\A\.?(?=.)/, ".")  # Ensure extension begins with dot.
#       end

#       # Cast 'delay' argument to a Float.
#       opts.on("--delay N", Float, "Delay N seconds before executing") do |n|
#         options.delay = n
#       end

#       # Cast 'time' argument to a Time object.
#       opts.on("-t", "--time [TIME]", Time, "Begin execution at given time") do |time|
#         options.time = time
#       end

#       # Cast to octal integer.
#       opts.on("-F", "--irs [OCTAL]", OptionParser::OctalInteger,
#               "Specify record separator (default \\0)") do |rs|
#         options.record_separator = rs
#       end

#       # List of arguments.
#       opts.on("--list x,y,z", Array, "Example 'list' of arguments") do |list|
#         options.list = list
#       end

#       # Keyword completion.  We are specifying a specific set of arguments (CODES
#       # and CODE_ALIASES - notice the latter is a Hash), and the user may provide
#       # the shortest unambiguous text.
#       code_list = (CODE_ALIASES.keys + CODES).join(',')
#       opts.on("--code CODE", CODES, CODE_ALIASES, "Select encoding",
#               "  (#{code_list})") do |encoding|
#         options.encoding = encoding
#       end

#       # Optional argument with keyword completion.
#       opts.on("--type [TYPE]", [:text, :binary, :auto],
#               "Select transfer type (text, binary, auto)") do |t|
#         options.transfer_type = t
#       end

#       # Boolean switch.
#       opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
#         options.verbose = v
#       end

#       opts.separator ""
#       opts.separator "Common options:"

#       # No argument, shows at tail.  This will print an options summary.
#       # Try it and see!
#       opts.on_tail("-h", "--help", "Show this message") do
#         puts opts
#         exit
#       end

#       # Another typical switch to print the version.
#       opts.on_tail("--version", "Show version") do
#         puts ::Version.join('.')
#         exit
#       end
#     end

#     opt_parser.parse!(args)
#     options
#   end  # parse()

# end  # class OptparseExample

# options = OptparseExample.parse(ARGV)
# pp options
# pp ARGV

#########################################
### ri OptionParser (minimal) example ###
# require 'optparse'

# options = {}
# OptionParser.new do |opts|
#   opts.banner = "Usage: example.rb [options]"

#   opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
#     options[:verbose] = v
#   end
# end.parse!

# p options
# p ARGV

## Test
# wurde@base:~$ ruby .rbcanvas/class_optparse.rb -v
# #=>{:verbose=>true}
# #=>[]
# wurde@base:~$ ruby .rbcanvas/class_optparse.rb -r
# #=>.rbcanvas/class_optparse.rb:145:in `<main>': invalid option: -r (OptionParser::InvalidOption)
# wurde@base:~$ ruby .rbcanvas/class_optparse.rb --no-verbose
# #=>{:verbose=>false}
# #=>[]
# wurde@base:~$ ruby .rbcanvas/class_optparse.rb --no-verbose blah
# #=>{:verbose=>false}
# #=>["blah"]
# wurde@base:~$ ruby .rbcanvas/class_optparse.rb --no-verbose blah blah blah
# #=>{:verbose=>false}
# #=>["blah", "blah", "blah"]

########################
### ri Documentation ###

## NOTE class methods
## accept, getopts, inc, new, reject, terminate, top, with

## NOTE instance methods
## abort, accept, banner, base, candidate, complete, def_head_option,
## def_option, def_tail_option, default_argv, define, define_head, define_tail,
## each_const, environment, getopts, help, inc, load, make_switch, new,
## notwice, on, on_head, on_tail, order, order!, parse, parse!, permute,
## permute!, program_name, reject, release, remove, search, search_const,
## separator, set_banner, set_program_name, set_summary_indent,
## set_summary_width, show_version, summarize, summary_indent, summary_width,
## terminate, to_a, to_s, top, ver, version, visit, warn

## NOTE attributes
## attr_accessor default_argv, attr_accessor set_summary_indent, attr_accessor
## set_summary_width, attr_accessor summary_indent, attr_accessor
## summary_width, attr_writer banner, attr_writer program_name, attr_writer
## release, attr_writer set_banner, attr_writer set_program_name, attr_writer
## version

## NOTE arguments
# Argument style::
#   One of the following:
#     :NONE, :REQUIRED, :OPTIONAL

# Argument pattern::
#   Acceptable option argument format, must be pre-defined with
#   OptionParser.accept or OptionParser#accept, or Regexp. This can appear once
#   or assigned as String if not present, otherwise causes an ArgumentError.
#   Examples:
#     Float, Time, Array

# Possible argument values::
#   Hash or Array.
#     [:text, :binary, :auto]
#     %w[iso-2022-jp shift_jis euc-jp utf8 binary]
#     { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

# Long style switch::
#   Specifies a long style switch which takes a mandatory, optional or no
#   argument. It's a string of the following form:
#     "--switch=MANDATORY" or "--switch MANDATORY"
#     "--switch[=OPTIONAL]"
#     "--switch"

# Short style switch::
#   Specifies short style switch which takes a mandatory, optional or no
#   argument. It's a string of the following form:
#     "-xMANDATORY"
#     "-x[OPTIONAL]"
#     "-x"

#   There is also a special form which matches character range (not full set of
#   regular expression):
#     "-[a-z]MANDATORY"
#     "-[a-z][OPTIONAL]"
#     "-[a-z]"

# Argument style and description::
#   Instead of specifying mandatory or optional arguments directly in the switch
#   parameter, this separate parameter can be used.
#     "=MANDATORY"
#     "=[OPTIONAL]"

# Description::
#   Description string for the option.
#     "Run verbosely"

# Handler::
#   Handler for the parsed argument value. Either give a block or pass a Proc or
#   Method as an argument.