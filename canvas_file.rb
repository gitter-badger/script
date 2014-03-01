#!/usr/bin/env ruby -w
# canvas_file.rb
# Description: Canvas File ruby class

TEST_FILE = ENV['HOME'] + "/Desktop/test_file.rb"

## > get first line of file

## UPDATE lines based on conditions
# File.delete(TEST_FILE)
# IO.write(TEST_FILE, "one\ntwo\nthree\n")
# transfer_file = String.new
# file = File.open(TEST_FILE, 'r+')
# file.each_line do |line|
#   if line.include?("t")
#     transfer_file << line.gsub("\n",'') + " :appended\n"
#   else
#     transfer_file << line
#   end
# end
# file.close
# File.open(TEST_FILE, 'w+') { |f| f.write(transfer_file) }
# puts IO.read(TEST_FILE)

## CREATE file
# IO.write(TEST_FILE, "one\ntwo\nthree\n")

## UPDATE lines. Write over each line sequentially.
# file = File.open(TEST_FILE, 'r+')
# file.write("one\n")
# file.write("two\n")
# file.write("three +")
# file.write(" four\n")
# file.each_line do |line|
#   puts "#{file.lineno}: #{line}"
# end
# file.close

# myfile = File.new("write.txt", "w+")    # open file for read and write
# ##=> #<File:write.txt>
# myfile.puts("This test line 1")         # write a line
# ##=> nil
# myfile.puts("This test line 2")         # write a second line
# ##=> nil
# myfile.rewind                           # move pointer back to start of file
# ##=> 0
# myfile.readline
# ##=> "This test line 1\n"
# myfile.readline
# ##=> "This test line 2\n"

## READ characters sequentially
# myfile = File.open("Hello.txt")
# ##=> #<File:temp.txt>
# myfile.getc.chr
# ##=> "H"
# myfile.getc.chr
# ##=> "e"
# myfile.getc.chr
# ##=> "l"

## READ lines sequentially with line number
# file = File.open(TEST_FILE, 'r+')
# file.each_line do |line|
#   puts "#{file.lineno}: #{line}"
# end
# #=> 1: one
# #=> 2: two
# #=> 3: three

## READ lines sequentially
# File.open(TEST_FILE, 'r+') do |file|
#   puts file.readline
#   puts file.readline
# end
##=> line: one
##=> line: two

## READ lines sequentially
# File.open(TEST_FILE, 'r+').each do |line|
#   puts line
# end
##=> line: one
##=> line: two
##=> line: threa

## READ lines sequentially
# File.open(TEST_FILE, 'r+').each_line do |line|
#   puts 'line: ' + line
# end
##=> line: one
##=> line: two
##=> line: three

## GET File information
# File.exists?("temp.txt")
# ##=> true
# File.file?("ruby")
# ##=> false
# File.directory?("ruby")
# ##=> true
# File.readable?("temp.txt")
# ##=> true
# File.writable?("temp.txt")
# ##=> true
# File.executable?("temp.txt")
# ##=> false
# File.size("temp.txt")
# ##=> 99
# File.zero?("temp.txt")
# ##=> false
# File.ftype("temp.txt")
# ##=> "file"
# File.ftype("../ruby")
# ##=> "directory"
# File.ftype("/dev/sda5")
# ##=> "blockSpecial"
# File.ctime("temp.txt")
# ##=> Thu Nov 29 10:51:18 EST 2007
# File.mtime("temp.txt")
# ##=> Thu Nov 29 11:14:18 EST 2007
# File.atime("temp.txt")
# ##=> Thu Nov 29 11:14:19 EST 2007


## CREATE file if it does not exist
# unless File.exist?(list)
#   File.new(list,'w+')
# end

## READ extension
# puts File.extname(TEST_FILE)

## READ file content
# puts File.open(TEST_FILE).readlines.size
# puts File.open(TEST_FILE).readlines[0]

## CREATE file
# File.new(TEST_FILE,'w+')

# = FFiillee  <<  IIOO

# ------------------------------------------------------------------------------
# = IInncclluuddeess::


## File < IO

# ------------------------------------------------------------------------------
## Includes

# FileBinary (from gem tins-0.13.1)

# (from ruby core)
# ------------------------------------------------------------------------------
# A File is an abstraction of any file object accessible by the program and is
# closely associated with class IO File includes the methods of module FileTest
# as class methods, allowing you to write (for example) File.exist?("foo").

# In the description of File methods, _p_e_r_m_i_s_s_i_o_n_
# _b_i_t_s are a platform-specific set of bits that indicate permissions of
# a file. On Unix-based systems, permissions are viewed as a set of three
# octets, for the owner, the group, and the rest of the world. For each of these
# entities, permissions may be set to read, write, or execute the file:

# The permission bits 0644 (in octal) would thus be interpreted as read/write
# for owner, and read-only for group and other. Higher-order bits may also be
# used to indicate the type of file (plain, directory, pipe, socket, and so on)
# and various other special features. If the permissions are for a directory,
# the meaning of the execute bit changes; when set the directory can be
# searched.

# On non-Posix operating systems, there may be only the ability to make a file
# read-only or read-write. In this case, the remaining permission bits will be
# synthesized to resemble typical values. For instance, on Windows NT the
# default permission bits are 0644, which means read/write for owner, read-only
# for all others. The only change that can be made is to make the file
# read-only, which is reported as 0444.

# Various constants for the methods in File can be found in File::Constants.
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::


# ALT_SEPARATOR:
#   platform specific alternative separator


# PATH_SEPARATOR:
#   path list separator


# SEPARATOR:
#   separates directory parts in path


# Separator:
#   separates directory parts in path

# ALT_SEPARATOR: platform specific alternative separator
# PATH_SEPARATOR: path list separator
# SEPARATOR: separates directory parts in path
# Separator: separates directory parts in path


## Class Methods
#   absolute_path
#   atime
#   basename
#   blockdev?
#   chardev?
#   chmod
#   chown
#   ctime
#   delete
#   directory?
#   dirname
#   executable?
#   executable_real?
#   exist?
#   exists?
#   expand_path
#   extname
#   file?
#   fnmatch
#   fnmatch?
#   ftype
#   grpowned?
#   identical?
#   join
#   lchmod
#   lchown
#   link
#   lstat
#   mtime
#   new
#   open
#   owned?
#   path
#   pipe?
#   readable?
#   readable_real?
#   readlink
#   realdirpath
#   realpath
#   rename
#   setgid?
#   setuid?
#   size
#   size?
#   socket?
#   split
#   stat
#   sticky?
#   symlink
#   symlink?
#   truncate
#   umask
#   unlink
#   utime
#   world_readable?
#   world_writable?
#   writable?
#   writable_real?
#   zero?

## Instance Methods
#   atime
#   chmod
#   chown
#   ctime
#   flock
#   lstat
#   mtime
#   path
#   size
#   to_path
#   truncate

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------

# = CCllaassss  mmeetthhooddss::


## Class methods
#   atomic_write

# ------------------------------------------------------------------------------
# Also found in:
#   gem tins-0.13.1

## File.open
# (from ruby core)
# ------------------------------------------------------------------------------
#   File.open(filename, mode="r" [, opt])                 -> file
#   File.open(filename [, mode [, perm]] [, opt])         -> file
#   File.open(filename, mode="r" [, opt]) {|file| block } -> obj
#   File.open(filename [, mode [, perm]] [, opt]) {|file| block } -> obj

# ------------------------------------------------------------------------------




# With no associated block, File.open is a synonym for File.new. If the optional
# code block is given, it will be passed the opened file as an argument and the
# File object will automatically be closed when the block terminates.  The value
# of the block will be returned from File.open.

# If a file is being created, its initial permissions may be set using the perm
# parameter.  See File.new for further discussion.

# See IO.new for a description of the mode and opt parameters.





## File.delete
# (from ruby core)
# ------------------------------------------------------------------------------
#   File.delete(file_name, ...)  -> integer
# ------------------------------------------------------------------------------
# Deletes the named files, returning the number of names passed as arguments.
# Raises an exception on any error. See also Dir::rmdir.



# File.basename("/home/gumby/work/ruby.rb")          #=> "ruby.rb"
# File.basename("/home/gumby/work/ruby.rb", ".rb")   #=> "ruby"



# File.basename("/home/gumby/work/ruby.rb")          #=> "ruby.rb"
# File.basename("/home/gumby/work/ruby.rb", ".rb")   #=> "ruby"


# Returns the extension (the portion of file name in path starting from the last
# period).
# If path is a dotfile, or starts with a period, then the starting dot is not
# dealt with the start of the extension.
# An empty string will also be returned when the period is the last character in
# path.
#   File.extname("test.rb")         #=> ".rb"
#   File.extname("a/b/d/test.rb")   #=> ".rb"
#   File.extname("foo.")            #=> ""
#   File.extname("test")            #=> ""
#   File.extname(".profile")        #=> ""
#   File.extname(".profile.sh")     #=> ".sh"

# Renames the given file to the new name. Raises a SystemCallError if the file
# cannot be renamed.
#   File.rename("afile", "afile.bak")   #=> 0



## File.readline ~OR~ IO.gets
# (from ruby core)
# ------------------------------------------------------------------------------
#   ios.gets(sep=$/)     -> string or nil
#   ios.gets(limit)      -> string or nil
#   ios.gets(sep, limit) -> string or nil
# ------------------------------------------------------------------------------
# Reads the next ``line'' from the I/O stream; lines are separated by _s_e_p.
# A separator of nil reads the entire contents, and a zero-length separator
# reads the input a paragraph at a time (two successive newlines in the input
# separate paragraphs). The stream must be opened for reading or an IOError will
# be raised. The line read in will be returned and also assigned to $_. Returns
# nil if called at end of file.  If the first argument is an integer, or
# optional second argument is given, the returning string would not be longer
# than the given value in bytes.

#   File.new("testfile").gets   #=> "This is line one\n"
#   $_                          #=> "This is line one\n"

## File.readline
# (from ruby core)
# ## Implementation from IO
# ------------------------------------------------------------------------------
#   ios.readline(sep=$/)     -> string
#   ios.readline(limit)      -> string
#   ios.readline(sep, limit) -> string
# ------------------------------------------------------------------------------
# Reads a line as with IO#gets, but raises an EOFError on end of file.
# (from ruby core)

# ## Implementation from Kernel
# ------------------------------------------------------------------------------
#   readline(sep=$/)     -> string
#   readline(limit)      -> string
#   readline(sep, limit) -> string
# ------------------------------------------------------------------------------
# Equivalent to Kernel::gets, except readline raises EOFError at end of file.


## File.copy_stream
# (from ruby core)
# ## Implementation from IO
# ------------------------------------------------------------------------------
#   IO.copy_stream(src, dst)
#   IO.copy_stream(src, dst, copy_length)
#   IO.copy_stream(src, dst, copy_length, src_offset)

# ------------------------------------------------------------------------------

# IO.copy_stream copies _src to _dst. _src and _dst is
# either a filename or an IO.

# This method returns the number of bytes copied.

# If optional arguments are not given, the start position of the copy is the
# beginning of the filename or the current file offset of the IO. The end
# position of the copy is the end of file.

# If _copy_length is given, No more than
# _copy_length bytes are copied.

# If _src_offset is given, it specifies the start position of
# the copy.

# When _src_offset is specified and _src is an IO,
# IO.copy_stream doesn't move the current file offset.

