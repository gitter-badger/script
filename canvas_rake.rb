#!/usr/bin/ruby -w
# canvas_rake.rb
# Author: Andy Bettisworth
# Description: Canvas Rake gem - a Rakefile is tailored to specifying tasks and actions

# my coworker exclaimed "Oh! I have the perfect name: Rake … Get it?
# Ruby-Make. Rake!" He said he envisioned the tasks as leaves and Rake would
# clean them up … or something like that. Anyways, the name stuck.
# -jim weirich

##################
### File Tasks ###
## NOTE used to specify file creation tasks.
## NOTE declared using the file method (instead of the task method).
# file "program" => ["a.o", "b.o"] do |t|
#   sh "cc -o #{t.name} #{t.prerequisites.join(' ')}"
# end
### File Tasks ###
##################

#######################
### Directory Tasks ###
## NOTE convenience method for creating a FileTask that creates a directory.
# directory "testdata/examples/doc"
## ~EQUIVALENT TO~
# file "testdata" do |t| mkdir t.name end
# file "testdata/examples" => ["testdata"] do |t| mkdir t.name end
# file "testdata/examples/doc" => ["testdata/examples"] do |t| mkdir t.name end

## NOTE directory method does not accept prerequisites or actions.
## NOTE but can be added using the file method.
# directory "testdata"
# file "testdata" => ["otherdata"]
# file "testdata" do
#   cp Dir["standard_data/*.data"], "testdata"
# end
### Directory Tasks ###
#######################

##################
### Dependency ###
## [Rakefile]
# directory "tmp"
#
# file "hello.tmp" => "tmp" do
#   sh "echo 'Hello' >> 'tmp/hello.tmp'"
# end
#$ rake hello.tmp
#=> mkdir -p tmp
#=> echo 'Hello' >> 'tmp/hello.tmp'
### Dependency ###
##################

##############
### Format ###
## Simple Task
# task :name

## Prerequisites
# task :name => [:prereq1, :prereq2]

## Action
# task :name => [:prereq1, :prereq2] do |t|
#   # > actions (may reference t)
# end

## Multiple Definitions - each adds its prerequisites and actions to the existing definition.
# task :name
# task :name => [:prereq1]
# task :name => [:prereq2]
# task :name do |t|
#   # > actions
# end
### Format ###
##############

########################
### Bag o' Functions ###
# module A
#   def b
#     puts "this is b"
#   end
# end

# class C
#   include A
# end

# d = C.new
# d.b #=> "this is b"
### Bag o' Functions ###
########################

#################
### Stateless ###
## NOTE - great when all state is stored in the database
# module A

#   module_function

#   def b
#     puts "this is b"
#   end

# end

# A.b #=> "this is b"
### Stateless ###
#################

#########################
### Command Processor ###
## EarGTD.process_command(ARGV)
## [lib/ear_gtd.rb]
# def process_command(cmd)
#   args = Array(cmd)
#   command = args.shift
#   case(command)
#   when "+"
#     add_task(args[0])
#   when "@"
#     t = tasks
#     puts t.empty? ? "Looks like you have nothing to do.\n" : t

#   # ... other commands omitted

#   else
#     puts "Que?"
#   end
# end
### Command Processor ###
#########################

##################
### Namespaces ###
## NOTE group together similar tasks inside of one namespace.
## e.g rake db:migrate (db is the namespace)
# namespace :morning do
#   task :turn_off_alarm
#     ....
#   end
# end
### Namespaces ###
##################

####################
### Default Task ###
## NOTE the task that will be run if you type rake without any arguments.
## [Rakefile]
# task :default => 'morning:turn_off_alarm'
#
# $ rake
#=> Turned off alarm. Would have liked 5 more minutes, though.
### Default Task ###
####################

######################
### Describe Tasks ###
## NOTE done on the line right above the task definition.
## NOTE gives you that nice output when you run rake -T
#
# desc "Make coffee"
# task :make_coffee do
#   cups = ENV["COFFEE_CUPS"] || 2
#   puts "Made #{cups} cups of coffee. Shakes are gone."
# end
#
#$ rake -T
#=> rake afternoon:make_coffee      # Make afternoon coffee
#=> rake morning:groom_myself       # Take care of normal hygeine tasks.
#=> rake morning:make_coffee        # Make coffee
#=> rake morning:ready_for_the_day  # Get ready for the day
#=> rake morning:turn_off_alarm     # Turn off alarm.
#=> rake morning:walk_dog           # Walk the dog

### Describe Tasks ###
######################

# = RRaakkee
# ------------------------------------------------------------------------------
# = IInncclluuddeess::
# Test::Unit::Assertions (from ruby core)

# Test::Unit::Assertions (from gem rake-10.1.1)
# ------------------------------------------------------------------------------
# = EExxtteennddeedd  bbyy::
# FileUtilsExt (from ruby core)

# FileUtilsExt (from gem rake-10.1.1)

# (from ruby core)
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::
# CommandLineOptionError:
#   [not documented]
# EARLY:
#   [not documented]
# EMPTY_TASK_ARGS:
#   [not documented]
# VERSION:
#   [not documented]

# = IInnssttaannccee  mmeetthhooddss::

#   add_rakelib
#   application
#   application=
#   load_rakefile
#   original_dir
#   run_tests

# (from gem rake-10.1.1)
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::
# CommandLineOptionError:
#   [not documented]
# EARLY:
#   [not documented
# EMPTY_TASK_ARGS:
#   [not documented]
# VERSION:
#   [not documented]

# = IInnssttaannccee  mmeetthhooddss::
#   add_rakelib
#   application
#   application=
#   load_rakefile
#   original_dir
#   run_tests

# ------------------------------------------------------------------------------
# Also found in:
#   gem bundler-1.5.2
#   gem capistrano-3.0.1

## USAGE
## rake [-f rakefile] {options} targets...
#
## Options are ...
#         --backtrace=[OUT]            Enable full backtrace.  OUT can be stderr (default) or stdout.
#         --comments                   Show commented tasks only
#         --job-stats [LEVEL]          Display job statistics. LEVEL=history displays a complete job list
#         --rules                      Trace the rules resolution.
#         --suppress-backtrace PATTERN Suppress backtrace lines matching regexp PATTERN. Ignored if --trace is on.
#     -A, --all                        Show all tasks, even uncommented ones
#     -D, --describe [PATTERN]         Describe the tasks (matching optional PATTERN), then exit.
#     -e, --execute CODE               Execute some Ruby code and exit.
#     -E, --execute-continue CODE      Execute some Ruby code, then continue with normal task processing.
#     -f, --rakefile [FILE]            Use FILE as the rakefile.
#     -G, --no-system, --nosystem      Use standard project Rakefile search paths, ignore system wide rakefiles.
#     -g, --system                     Using system wide (global) rakefiles (usually '~/.rake/*.rake').
#     -I, --libdir LIBDIR              Include LIBDIR in the search path for required modules.
#     -j, --jobs [NUMBER]              Specifies the maximum number of tasks to execute in parallel. (default is 2)
#     -m, --multitask                  Treat all tasks as multitasks.
#     -n, --dry-run                    Do a dry run without executing actions.
#     -N, --no-search, --nosearch      Do not search parent directories for the Rakefile.
#     -P, --prereqs                    Display the tasks and dependencies, then exit.
#     -p, --execute-print CODE         Execute some Ruby code, print the result, then exit.
#     -q, --quiet                      Do not log messages to standard output.
#     -r, --require MODULE             Require MODULE before executing rakefile.
#     -R, --rakelibdir RAKELIBDIR,     Auto-import any .rake files in RAKELIBDIR. (default is 'rakelib')
#         --rakelib
#     -s, --silent                     Like --quiet, but also suppresses the 'in directory' announcement.
#     -t, --trace=[OUT]                Turn on invoke/execute tracing, enable full backtrace. OUT can be stderr (default) or stdout.
#     -T, --tasks [PATTERN]            Display the tasks (matching optional PATTERN) with descriptions, then exit.
#     -v, --verbose                    Log message to standard output.
#     -V, --version                    Display the program version.
#     -W, --where [PATTERN]            Describe the tasks (matching optional PATTERN), then exit.
#     -X, --no-deprecation-warnings    Disable the deprecation warnings.
#     -h, -H, --help                   Display this help message.
