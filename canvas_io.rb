#!/usr/bin/env ruby -w
# canvas_io.rb
# Description: Canvas IO ruby class

TEST_FILE = ENV['HOME'] + "/Desktop/test_file.rb"

## IO < Object
# ------------------------------------------------------------------------------
# = IInncclluuddeess::
# (from ruby core)
#   File::Constants
#   Enumerable

# ------------------------------------------------------------------------------
# = EExxtteennddeedd  bbyy::
# (from gem tins-0.13.1)
#   Tins::SecureWrite
#   Tins::Write

# (from ruby core)
# ------------------------------------------------------------------------------

# Expect library adds the IO instance method #expect, which does similar act to
# tcl's expect extension.

# In order to use this method, you must require expect:

#   require 'expect'

# Please see #expect for usage.

# The IO class is the basis for all input and output in Ruby. An I/O stream may
# be _d_u_p_l_e_x_e_d (that is, bidirectional), and so may use more than
# one native operating system stream.

# Many of the examples in this section use the File class, the only standard
# subclass of IO. The two classes are closely associated.  Like the File class,
# the Socket library subclasses from IO (such as TCPSocket or UDPSocket).

# The Kernel#open method can create an IO (or File) object for these types of
# arguments:

# * A plain string represents a filename suitable for the underlying operating
#   system.

# * A string starting with "|" indicates a subprocess. The remainder of the
#   string following the "|" is invoked as a process with appropriate
#   input/output channels connected to it.

# * A string equal to "|-" will create another Ruby instance as a subprocess.

# The IO may be opened with different file modes (read-only, write-only) and
# encodings for proper conversion.  See IO.new for these options.  See
# Kernel#open for details of the various command formats described above.

# IO.popen, the Open3 library, or  Process#spawn may also be used to communicate
# with subprocesses through an IO.

# Ruby will convert pathnames between different operating system conventions if
# possible.  For instance, on a Windows system the filename
# "/gumby/ruby/test.rb" will be opened as "\gumby\ruby\test.rb".  When
# specifying a Windows-style filename in a Ruby string, remember to escape the
# backslashes:

#   "c:\\gumby\\ruby\\test.rb"

# Our examples here will use the Unix-style forward slashes; File::ALT_SEPARATOR
# can be used to get the platform-specific separator character.

# The global constant ARGF (also accessible as $<) provides an IO-like stream
# which allows access to all files mentioned on the command line (or STDIN if no
# files are mentioned). ARGF#path and its alias ARGF#filename are provided to
# access the name of the file currently being read.

# == iioo//ccoonnssoollee

# The io/console extension provides methods for interacting with the console.
# The console can be accessed from IO.console or the standard input/output/error
# IO objects.
# Requiring io/console adds the following methods:

# * IO::console
# * IO#raw
# * IO#raw!
# * IO#cooked
# * IO#cooked!
# * IO#getch
# * IO#echo=
# * IO#echo?
# * IO#noecho
# * IO#winsize
# * IO#winsize=
# * IO#iflush
# * IO#ioflush
# * IO#oflush

## Example:
#   require 'io/console'
#   rows, columns = $stdin.winsize
#   puts "Your screen is #{columns} wide and #{rows} tall"

# ------------------------------------------------------------------------------
## Constants
# EWOULDBLOCKWaitReadable: EAGAINWaitReadable
# EWOULDBLOCKWaitWritable: EAGAINWaitWritable
# SEEK_CUR: Set I/O position from the current position
# SEEK_DATA: Set I/O position to the next location containing data
# SEEK_END: Set I/O position from the end
# SEEK_HOLE: Set I/O position to the next hole
# SEEK_SET: Set I/O position from the beginning

## Class methods
#   binread
#   binwrite
#   console
#   copy_stream
#   for_fd
#   foreach
#   new
#   open
#   pipe
#   popen
#   read
#   readlines
#   select
#   sysopen
#   try_convert
#   write

## Instance methods
#   <<
#   advise
#   autoclose=
#   autoclose?
#   binmode
#   binmode?
#   block_scanf
#   bytes
#   chars
#   close
#   close_on_exec=
#   close_on_exec?
#   close_read
#   close_write
#   closed?
#   codepoints
#   cooked
#   cooked!
#   each
#   each_byte
#   each_char
#   each_codepoint
#   each_line
#   echo=
#   echo?
#   eof
#   eof?
#   expect
#   external_encoding
#   fcntl
#   fdatasync
#   fileno
#   flush
#   fsync
#   getbyte
#   getc
#   getch
#   gets
#   iflush
#   inspect
#   internal_encoding
#   ioctl
#   ioflush
#   isatty
#   lineno
#   lineno=
#   lines
#   noecho
#   nonblock
#   nonblock=
#   nonblock?
#   nread
#   oflush
#   pid
#   pos
#   pos=
#   print
#   printf
#   putc
#   puts
#   raw
#   raw!
#   read
#   read_nonblock
#   readbyte
#   readchar
#   readline
#   readlines
#   readpartial
#   ready?
#   reopen
#   rewind
#   scanf
#   seek
#   set_encoding
#   soak_up_spaces
#   stat
#   sync
#   sync=
#   sysread
#   sysseek
#   syswrite
#   tell
#   to_i
#   to_io
#   tty?
#   ungetbyte
#   ungetc
#   wait
#   wait_readable
#   wait_writable
#   winsize
#   winsize=
#   write
#   write_nonblock

# (from gem tins-0.13.1)
# ------------------------------------------------------------------------------
# class ::Object
#   include Tins::SecureWrite

# end

# class ::Object
#   include Tins::Write

# end
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Also found in:
#   gem highline-1.6.20
#   gem thor-0.18.1


## IO.popen
# (from ruby core)
# ------------------------------------------------------------------------------
#   IO.popen([env,] cmd, mode="r" [, opt])               -> io
#   IO.popen([env,] cmd, mode="r" [, opt]) {|io| block } -> obj

# ------------------------------------------------------------------------------

# Runs the specified command as a subprocess; the subprocess's standard input
# and output will be connected to the returned IO object.

# The PID of the started process can be obtained by IO#pid method.

# _c_m_d is a string or an array as follows.

#   cmd:
#     "-"                                      : fork
#     commandline                              : command line string which is passed to a shell
#     [env, cmdname, arg1, ..., opts]          : command name and zero or more arguments (no shell)
#     [env, [cmdname, argv0], arg1, ..., opts] : command name, argv[0] and zero or more arguments (no shell)
#   (env and opts are optional.)

# If _c_m_d is a String ``-'', then a new instance of Ruby is started as the
# subprocess.

# If _c_m_d is an Array of String, then it will be used as the subprocess's
# argv bypassing a shell. The array can contains a hash at first for
# environments and a hash at last for options similar to spawn.

# The default mode for the new file object is ``r'', but _m_o_d_e may be set
# to any of the modes listed in the description for class IO. The last argument
# _o_p_t qualifies _m_o_d_e.

#   # set IO encoding
#   IO.popen("nkf -e filename", :external_encoding=>"EUC-JP") {|nkf_io|
#     euc_jp_string = nkf_io.read
#   }

#   # merge standard output and standard error using
#   # spawn option.  See the document of Kernel.spawn.
#   IO.popen(["ls", "/", :err=>[:child, :out]]) {|ls_io|
#     ls_result_with_error = ls_io.read
#   }

#   # spawn options can be mixed with IO options
#   IO.popen(["ls", "/"], :err=>[:child, :out]) {|ls_io|
#     ls_result_with_error = ls_io.read
#   }

# Raises exceptions which IO.pipe and Kernel.spawn raise.

# If a block is given, Ruby will run the command as a child connected to Ruby
# with a pipe. Ruby's end of the pipe will be passed as a parameter to the
# block. At the end of block, Ruby close the pipe and sets $?. In this case
# IO.popen returns the value of the block.

# If a block is given with a _c_m_d of ``-'', the block will be run in two
# separate processes: once in the parent, and once in a child. The parent
# process will be passed the pipe object as a parameter to the block, the child
# version of the block will be passed nil, and the child's standard in and
# standard out will be connected to the parent through the pipe. Not available
# on all platforms.

# f = IO.popen("uname")
# p f.readlines
# f.close
# puts "Parent is #{Process.pid}"
# IO.popen("date") { |f| puts f.gets }
# IO.popen("-") {|f| $stderr.puts "#{Process.pid} is here, f is #{f.inspect}"}
# p $?
# IO.popen(%w"sed -e s|^|<foo>| -e s&$&;zot;&", "r+") {|f|
#   f.puts "bar"; f.close_write; puts f.gets
# }

# _p_r_o_d_u_c_e_s_:

# ["Linux\n"]
# Parent is 21346
# Thu Jan 15 22:41:19 JST 2009
# 21346 is here, f is #<IO:fd 3>
# 21352 is here, f is nil
# #<Process::Status: pid 21352 exit 0>
# <foo>bar;zot;


