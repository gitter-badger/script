#!/usr/bin/env ruby -w
# canvas_dir.rb
# Description: Canvas Dir ruby class

## READ list of directories
# Dir["**/"].each do |dir|
#   puts dir
# end

# TEST_DIR = ENV['HOME'] + "/Desktop/test_dir"
# Dir.mkdir(TEST_DIR)

## Dir < Object
# ------------------------------------------------------------------------------
## INCLUDES:
# Enumerable (from ruby core)

# (from ruby core)
# ------------------------------------------------------------------------------
# Objects of class Dir are directory streams representing directories in the
# underlying file system. They provide a variety of ways to list directories and
# their contents. See also File.

# The directory used in these examples contains the two regular files (config.h
# and main.rb), the parent directory (..), and the directory itself (.).
# ------------------------------------------------------------------------------

## Class Methods
#   []
#   chdir
#   chroot
#   delete
#   entries
#   exist?
#   exists?
#   foreach
#   getwd
#   glob
#   home
#   mkdir
#   mktmpdir
#   new
#   open
#   pwd
#   rmdir
#   tmpdir
#   unlink

## Instance Methods
#   close
#   each
#   inspect
#   path
#   pos
#   pos=
#   read
#   rewind
#   seek
#   tell
#   to_path

## Dir.mkdir
# (from ruby core)
# ------------------------------------------------------------------------------
#   Dir.mkdir( string [, integer] ) -> 0
# ------------------------------------------------------------------------------
# Makes a new directory named string, with permissions. The permissions may be
# modified by the value of File::umask, and are ignored on NT. Raises a
# SystemCallError if the directory cannot be created. See also the discussion of
# permissions in the class documentation for File.

#   Dir.mkdir(File.join(Dir.home, ".foo"), 0700) #=> 0

## Dir.delete
# (from ruby core)
# ------------------------------------------------------------------------------
#   Dir.delete( string ) -> 0
# ------------------------------------------------------------------------------
# Deletes the named directory. Raises a subclass of SystemCallError if the
# directory isn't empty.

## SEARCH for file in all subdirectories
# class SearchForFile
#   def locate(target_file)
#     ## Search current directory
#     Dir.foreach('.') do |item|
#       next if item == '.' or item == '..' or File.directory?(item)
#       return File.join(File.absolute_path(recursive_dir), item) if item =~ /#{target_file}/
#     end
#     ## Search all subdirectories
#     Dir["**/"].each do |recursive_dir|
#       Dir.foreach(recursive_dir) do |item|
#         next if item == '.' or item == '..' or File.directory?(item)
#         return File.join(File.absolute_path(recursive_dir), item) if item =~ /#{target_file}/
#       end
#     end
#   end
# end
# find_file = SearchForFile.new
# puts find_file.locate('schema.rb')
