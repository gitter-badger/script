#!/usr/bin/ruby -w
# canvas_git.rb
# Author: Andy Bettisworth
# Description: Canvas git package

## DELETE remote branch
# git push origin --delete <branch>

## READ current branch
# project = "#{ENV['HOME']}/Desktop/test_project"
# checkout_branch = `cd #{project}; git rev-parse --abbrev-ref HEAD`
# puts 'branch: ' + checkout_branch

## USAGE branch feature and commit init
# git checkout -b feature/blah
# git commit -am "init feature/blah"

## USAGE - git stash
## save changes made in the current index and working directory for later
# git stash
# git stash list ## view current stashes available
# git stash apply ## top apply stash to current working directory
# git stash drop ## remove last stash
# git stash drop stash@{1} ## remove target stash
# git stash clear ## remove all stashes

## USAGE - git-reset
# git reset HEAD ## used to unstage files from index and reset pointer to HEAD
# git reset HEAD -- <target_file> ## unstage target file
## EXAMPLE is you want to separate the commits of two files already in stage

## USAGE - configure commit author
# git config user.name "wurde"
# git config user.email "wurde@gmail.com"

## USAGE - bare double dash "--"
# git checkout main.c
  # Checkout the tag named "main.c"
# git checkout -- main.c
  # Checkout the file named "main.c"

## USAGE - Add a new remote, fetch, and check out a branch from it
# git remote origin
# git branch -r origin/master
# git remote add linux-nfs git://linux-nfs.org/pub/linux/nfs-2.6.git
# git remote linux-nfs origin
# git fetch * refs/remotes/linux-nfs/master: storing branch 'master' commit:bf81b46
# git branch -r origin/master linux-nfs/master
# git checkout -b nfs linux-nfs/master

## USAGE - clone repo
# git clone /path/to/repository
# git clone username@host:/path/to/repository
# git clone github.com/wurde/rbdefault.git
# git clone git://github.com/schacon/simplegit.git

## USAGE - commit history
# git log
# git log --oneline

## USAGE - branch feature
# git branch
# git branch feature/blah
# git checkout feature/blah
# git branch -d feature/blah ## delete branch

## USAGE - initialize project
# git init
# git add .
# git commit -m "init"

############
### HELP ###

# usage: git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
#            [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
#            [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
#            [-c name=value] [--help]
#            <command> [<args>]

# The most commonly used git commands are:
#    add        Add file contents to the index
#    bisect     Find by binary search the change that introduced a bug
#    branch     List, create, or delete branches
#    checkout   Checkout a branch or paths to the working tree
#    clone      Clone a repository into a new directory
#    commit     Record changes to the repository
#    diff       Show changes between commits, commit and working tree, etc
#    fetch      Download objects and refs from another repository
#    grep       Print lines matching a pattern
#    init       Create an empty git repository or reinitialize an existing one
#    log        Show commit logs
#    merge      Join two or more development histories together
#    mv         Move or rename a file, a directory, or a symlink
#    pull       Fetch from and merge with another repository or a local branch
#    push       Update remote refs along with associated objects
#    rebase     Forward-port local commits to the updated upstream head
#    reset      Reset current HEAD to the specified state
#    rm         Remove files from the working tree and from the index
#    show       Show various types of objects
#    status     Show the working tree status
#    tag        Create, list, delete or verify a tag object signed with GPG

# See 'git help <command>' for more information on a specific command.

### HELP ###
############

###############
### MANPAGE ###

# GIT(1)                                            Git Manual                                            GIT(1)

# NAME
#        git - the stupid content tracker

# SYNOPSIS
#        git [--version] [--help] [-c <name>=<value>]
#            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
#            [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
#            [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
#            <command> [<args>]

# DESCRIPTION
#        Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

#        See gittutorial(7) to get started, then see Everyday Git[1] for a useful minimum set of commands, and "man git-commandname" for documentation of each command. CVS users may also want to read gitcvs-migration(7). See the Git User’s Manual[2] for a more in-depth introduction. The <command> is either a name of a Git command (see below) or an alias as defined in the configuration file (see git-config(1)). Formatted and hyperlinked version of the latest git documentation can be viewed at http://www.kernel.org/pub/software/scm/git/docs/.

# OPTIONS
#        --version
#            Prints the git suite version that the git program came from.

#        --help
#            Prints the synopsis and a list of the most commonly used commands. If the option --all or -a is given then all available commands are printed. If a git command is named this option will bring up the manual page for that command.

#        -c <name>=<value>
#            Pass a configuration parameter to the command. The value given will override values from configuration files. The <name> is expected in the same format as listed by git config (subkeys separated by dots).

#        --exec-path[=<path>]
#            Path to wherever your core git programs are installed. This can also be controlled by setting the GIT_EXEC_PATH environment variable. If no path is given, git will print the current setting and
#            then exit.

#        --html-path
#            Print the path, without trailing slash, where git’s HTML documentation is installed and exit.

#        --man-path
#            Print the manpath (see man(1)) for the man pages for this version of git and exit.

#        --info-path
#            Print the path where the Info files documenting this version of git are installed and exit.

#        -p, --paginate
#            Pipe all output into less (or if set, $PAGER) if standard output is a terminal. This overrides the pager.<cmd> configuration options (see the "Configuration Mechanism" section below).

#        --no-pager
#            Do not pipe git output into a pager.

#        --git-dir=<path>
#            Set the path to the repository. This can also be controlled by setting the GIT_DIR environment variable. It can be an absolute path or relative path to current working directory.

#        --work-tree=<path>
#            Set the path to the working tree. It can be an absolute path or a path relative to the current working directory. This can also be controlled by setting the GIT_WORK_TREE environment variable and the core.worktree configuration variable (see core.worktree in git-config(1) for a more detailed discussion).

#        --namespace=<path>
#            Set the git namespace. See gitnamespaces(7) for more details. Equivalent to setting the GIT_NAMESPACE environment variable.

#        --bare
#            Treat the repository as a bare repository. If GIT_DIR environment is not set, it is set to the current working directory.

#        --no-replace-objects
#            Do not use replacement refs to replace git objects. See git-replace(1) for more information.

# FURTHER DOCUMENTATION
#        See the references above to get started using git. The following is probably more detail than necessary
#        for a first-time user.
#        The git concepts chapter of the user-manual[3] and gitcore-tutorial(7) both provide introductions to
#        the underlying git architecture.
#        See gitworkflows(7) for an overview of recommended workflows.
#        See also the howto[4] documents for some useful examples.
#        The internals are documented in the GIT API documentation[5].

# GIT COMMANDS
#        We divide git into high level ("porcelain") commands and low level ("plumbing") commands.

# HIGH-LEVEL COMMANDS (PORCELAIN)
#        We separate the porcelain commands into the main commands and some ancillary user utilities.

#    Main porcelain commands
#        git-add(1)
#            Add file contents to the index.

#        git-am(1)
#            Apply a series of patches from a mailbox.

#        git-archive(1)
#            Create an archive of files from a named tree.

#        git-bisect(1)
#            Find by binary search the change that introduced a bug.

#        git-branch(1)
#            List, create, or delete branches.

#        git-bundle(1)
#            Move objects and refs by archive.

#        git-checkout(1)
#            Checkout a branch or paths to the working tree.

#        git-cherry-pick(1)
#            Apply the changes introduced by some existing commits.

#        git-citool(1)
#            Graphical alternative to git-commit.

#        git-clean(1)
#            Remove untracked files from the working tree.

#        git-clone(1)
#            Clone a repository into a new directory.

#        git-commit(1)
#            Record changes to the repository.

#        git-describe(1)
#            Show the most recent tag that is reachable from a commit.

#        git-diff(1)
#            Show changes between commits, commit and working tree, etc.

#        git-fetch(1)
#            Download objects and refs from another repository.

#        git-format-patch(1)
#            Prepare patches for e-mail submission.

#        git-gc(1)
#            Cleanup unnecessary files and optimize the local repository.

#        git-grep(1)
#            Print lines matching a pattern.

#        git-gui(1)
#            A portable graphical interface to Git.

#        git-init(1)
#            Create an empty git repository or reinitialize an existing one.

#        git-log(1)
#            Show commit logs.

#        git-merge(1)
#            Join two or more development histories together.

#        git-mv(1)
#            Move or rename a file, a directory, or a symlink.

#        git-notes(1)
#            Add or inspect object notes.

#        git-pull(1)
#            Fetch from and merge with another repository or a local branch.

#        git-push(1)
#            Update remote refs along with associated objects.

#        git-rebase(1)
#            Forward-port local commits to the updated upstream head.

#        git-reset(1)
#            Reset current HEAD to the specified state.

#        git-revert(1)
#            Revert some existing commits.

#        git-rm(1)
#            Remove files from the working tree and from the index.

#        git-shortlog(1)
#            Summarize git log output.

#        git-show(1)
#            Show various types of objects.

#        git-stash(1)
#            Stash the changes in a dirty working directory away.

#        git-status(1)
#            Show the working tree status.

#        git-submodule(1)
#            Initialize, update or inspect submodules.

#        git-tag(1)
#            Create, list, delete or verify a tag object signed with GPG.

#        gitk(1)
#            The git repository browser.

#    Ancillary Commands
#        Manipulators:

#        git-config(1)
#            Get and set repository or global options.

#        git-fast-export(1)
#            Git data exporter.

#        git-fast-import(1)
#            Backend for fast Git data importers.

#        git-filter-branch(1)
#            Rewrite branches.

#        git-lost-found(1)
#            (deprecated) Recover lost refs that luckily have not yet been pruned.

#        git-mergetool(1)
#            Run merge conflict resolution tools to resolve merge conflicts.

#        git-pack-refs(1)
#            Pack heads and tags for efficient repository access.

#        git-prune(1)
#            Prune all unreachable objects from the object database.

#        git-reflog(1)
#            Manage reflog information.

#        git-relink(1)
#            Hardlink common objects in local repositories.

#        git-remote(1)
#            manage set of tracked repositories.

#        git-repack(1)
#            Pack unpacked objects in a repository.

#        git-replace(1)
#            Create, list, delete refs to replace objects.

#        git-repo-config(1)
#            (deprecated) Get and set repository or global options.

#        Interrogators:

#        git-annotate(1)
#            Annotate file lines with commit information.

#        git-blame(1)
#            Show what revision and author last modified each line of a file.

#        git-cherry(1)
#            Find commits not merged upstream.

#        git-count-objects(1)
#            Count unpacked number of objects and their disk consumption.

#        git-difftool(1)
#            Show changes using common diff tools.

#        git-fsck(1)
#            Verifies the connectivity and validity of the objects in the database.

#        git-get-tar-commit-id(1)
#            Extract commit ID from an archive created using git-archive.

#        git-help(1)
#            display help information about git.

#        git-instaweb(1)
#            Instantly browse your working repository in gitweb.

#        git-merge-tree(1)
#            Show three-way merge without touching index.

#        git-rerere(1)
#            Reuse recorded resolution of conflicted merges.

#        git-rev-parse(1)
#            Pick out and massage parameters.

#        git-show-branch(1)
#            Show branches and their commits.

#        git-verify-tag(1)
#            Check the GPG signature of tags.

#        git-whatchanged(1)
#            Show logs with difference each commit introduces.

#        gitweb(1)
#            Git web interface (web frontend to Git repositories).

#    Interacting with Others
#        These commands are to interact with foreign SCM and with other people via patch over e-mail.

#        git-archimport(1)
#            Import an Arch repository into git.

#        git-cvsexportcommit(1)
#            Export a single commit to a CVS checkout.

#        git-cvsimport(1)
#            Salvage your data out of another SCM people love to hate.

#        git-cvsserver(1)
#            A CVS server emulator for git.

#        git-imap-send(1)
#            Send a collection of patches from stdin to an IMAP folder.

#        git-quiltimport(1)
#            Applies a quilt patchset onto the current branch.

#        git-request-pull(1)
#            Generates a summary of pending changes.

#        git-send-email(1)
#            Send a collection of patches as emails.

#        git-svn(1)
#            Bidirectional operation between a Subversion repository and git.

# LOW-LEVEL COMMANDS (PLUMBING)
#        Although git includes its own porcelain layer, its low-level commands are sufficient to support development of alternative porcelains. Developers of such porcelains might start by reading about git- update-index(1) and git-read-tree(1).

#        The interface (input, output, set of options and the semantics) to these low-level commands are meant to be a lot more stable than Porcelain level commands, because these commands are primarily for scripted use. The interface to Porcelain commands on the other hand are subject to change in order to improve the end user experience.

#        The following description divides the low-level commands into commands that manipulate objects (in the repository, index, and working tree), commands that interrogate and compare objects, and commands that move objects and references between repositories.

#    Manipulation commands
#        git-apply(1)
#            Apply a patch to files and/or to the index.

#        git-checkout-index(1)
#            Copy files from the index to the working tree.

#        git-commit-tree(1)
#            Create a new commit object.

#        git-hash-object(1)
#            Compute object ID and optionally creates a blob from a file.

#        git-index-pack(1)
#            Build pack index file for an existing packed archive.

#        git-merge-file(1)
#            Run a three-way file merge.

#        git-merge-index(1)
#            Run a merge for files needing merging.

#        git-mktag(1)
#            Creates a tag object.

#        git-mktree(1)
#            Build a tree-object from ls-tree formatted text.

#        git-pack-objects(1)
#            Create a packed archive of objects.

#        git-prune-packed(1)
#            Remove extra objects that are already in pack files.

#        git-read-tree(1)
#            Reads tree information into the index.

#        git-symbolic-ref(1)
#            Read and modify symbolic refs.

#        git-unpack-objects(1)
#            Unpack objects from a packed archive.

#        git-update-index(1)
#            Register file contents in the working tree to the index.

#        git-update-ref(1)
#            Update the object name stored in a ref safely.

#        git-write-tree(1)
#            Create a tree object from the current index.

#    Interrogation commands
#        git-cat-file(1)
#            Provide content or type and size information for repository objects.

#        git-diff-files(1)
#            Compares files in the working tree and the index.

#        git-diff-index(1)
#            Compares content and mode of blobs between the index and repository.

#        git-diff-tree(1)
#            Compares the content and mode of blobs found via two tree objects.

#        git-for-each-ref(1)
#            Output information on each ref.

#        git-ls-files(1)
#            Show information about files in the index and the working tree.

#        git-ls-remote(1)
#            List references in a remote repository.

#        git-ls-tree(1)
#            List the contents of a tree object.

#        git-merge-base(1)
#            Find as good common ancestors as possible for a merge.

#        git-name-rev(1)
#            Find symbolic names for given revs.

#        git-pack-redundant(1)
#            Find redundant pack files.

#        git-rev-list(1)
#            Lists commit objects in reverse chronological order.

#        git-show-index(1)
#            Show packed archive index.

#        git-show-ref(1)
#            List references in a local repository.

#        git-tar-tree(1)
#            (deprecated) Create a tar archive of the files in the named tree object.

#        git-unpack-file(1)
#            Creates a temporary file with a blob’s contents.

#        git-var(1)
#            Show a git logical variable.

#        git-verify-pack(1)
#            Validate packed git archive files.

#        In general, the interrogate commands do not touch the files in the working tree.

#    Synching repositories
#        git-daemon(1)
#            A really simple server for git repositories.

#        git-fetch-pack(1)
#            Receive missing objects from another repository.

#        git-http-backend(1)
#            Server side implementation of Git over HTTP.

#        git-send-pack(1)
#            Push objects over git protocol to another repository.

#        git-update-server-info(1)
#            Update auxiliary info file to help dumb servers.

#        The following are helper commands used by the above; end users typically do not use them directly.

#        git-http-fetch(1)
#            Download from a remote git repository via HTTP.

#        git-http-push(1)
#            Push objects over HTTP/DAV to another repository.

#        git-parse-remote(1)
#            Routines to help parsing remote repository access parameters.

#        git-receive-pack(1)
#            Receive what is pushed into the repository.

#        git-shell(1)
#            Restricted login shell for Git-only SSH access.

#        git-upload-archive(1)
#            Send archive back to git-archive.

#        git-upload-pack(1)
#            Send objects packed back to git-fetch-pack.

#    Internal helper commands
#        These are internal helper commands used by other commands; end users typically do not use them
#        directly.

#        git-check-attr(1)
#            Display gitattributes information.

#        git-check-ref-format(1)
#            Ensures that a reference name is well formed.

#        git-fmt-merge-msg(1)
#            Produce a merge commit message.

#        git-mailinfo(1)
#            Extracts patch and authorship from a single e-mail message.

#        git-mailsplit(1)
#            Simple UNIX mbox splitter program.

#        git-merge-one-file(1)
#            The standard helper program to use with git-merge-index.

#        git-patch-id(1)
#            Compute unique ID for a patch.

#        git-peek-remote(1)
#            (deprecated) List the references in a remote repository.

#        git-sh-setup(1)
#            Common git shell script setup code.

#        git-stripspace(1)
#            Remove unnecessary whitespace.

# CONFIGURATION MECHANISM
#        Starting from 0.99.9 (actually mid 0.99.8.GIT), .git/config file is used to hold per-repository
#        configuration options. It is a simple text file modeled after .ini format familiar to some people. Here
#        is an example:

#            #
#            # A '#' or ';' character indicates a comment.
#            #

#            ; core variables
#            [core]
#                    ; Don't trust file modes
#                    filemode = false

#            ; user identity
#            [user]
#                    name = "Junio C Hamano"
#                    email = "junkio@twinsun.com"


#        Various commands read from the configuration file and adjust their operation accordingly. See git-
#        config(1) for a list.

# IDENTIFIER TERMINOLOGY
#        <object>
#            Indicates the object name for any type of object.

#        <blob>
#            Indicates a blob object name.

#        <tree>
#            Indicates a tree object name.

#        <commit>
#            Indicates a commit object name.

#        <tree-ish>
#            Indicates a tree, commit or tag object name. A command that takes a <tree-ish> argument ultimately
#            wants to operate on a <tree> object but automatically dereferences <commit> and <tag> objects that
#            point at a <tree>.

#        <commit-ish>
#            Indicates a commit or tag object name. A command that takes a <commit-ish> argument ultimately
#            wants to operate on a <commit> object but automatically dereferences <tag> objects that point at a
#            <commit>.

#        <type>
#            Indicates that an object type is required. Currently one of: blob, tree, commit, or tag.

#        <file>
#            Indicates a filename - almost always relative to the root of the tree structure GIT_INDEX_FILE
#            describes.

# SYMBOLIC IDENTIFIERS
#        Any git command accepting any <object> can also use the following symbolic notation:

#        HEAD
#            indicates the head of the current branch.

#        <tag>
#            a valid tag name (i.e. a refs/tags/<tag> reference).

#        <head>
#            a valid head name (i.e. a refs/heads/<head> reference).

#        For a more complete list of ways to spell object names, see "SPECIFYING REVISIONS" section in
#        gitrevisions(7).

# FILE/DIRECTORY STRUCTURE
#        Please see the gitrepository-layout(5) document.

#        Read githooks(5) for more details about each hook.

#        Higher level SCMs may provide and manage additional information in the $GIT_DIR.

# TERMINOLOGY
#        Please see gitglossary(7).

# ENVIRONMENT VARIABLES
#        Various git commands use the following environment variables:

#    The git Repository
#        These environment variables apply to all core git commands. Nb: it is worth noting that they may be
#        used/overridden by SCMS sitting above git so take care if using Cogito etc.

#        GIT_INDEX_FILE
#            This environment allows the specification of an alternate index file. If not specified, the default
#            of $GIT_DIR/index is used.

#        GIT_OBJECT_DIRECTORY
#            If the object storage directory is specified via this environment variable then the sha1
#            directories are created underneath - otherwise the default $GIT_DIR/objects directory is used.

#        GIT_ALTERNATE_OBJECT_DIRECTORIES
#            Due to the immutable nature of git objects, old objects can be archived into shared, read-only
#            directories. This variable specifies a ":" separated (on Windows ";" separated) list of git object
#            directories which can be used to search for git objects. New objects will not be written to these
#            directories.

#        GIT_DIR
#            If the GIT_DIR environment variable is set then it specifies a path to use instead of the default
#            .git for the base of the repository.

#        GIT_WORK_TREE
#            Set the path to the working tree. The value will not be used in combination with repositories found
#            automatically in a .git directory (i.e. $GIT_DIR is not set). This can also be controlled by the
#            --work-tree command line option and the core.worktree configuration variable.

#        GIT_NAMESPACE
#            Set the git namespace; see gitnamespaces(7) for details. The --namespace command-line option also
#            sets this value.

#        GIT_CEILING_DIRECTORIES
#            This should be a colon-separated list of absolute paths. If set, it is a list of directories that
#            git should not chdir up into while looking for a repository directory. It will not exclude the
#            current working directory or a GIT_DIR set on the command line or in the environment. (Useful for
#            excluding slow-loading network directories.)

#        GIT_DISCOVERY_ACROSS_FILESYSTEM
#            When run in a directory that does not have ".git" repository directory, git tries to find such a
#            directory in the parent directories to find the top of the working tree, but by default it does not
#            cross filesystem boundaries. This environment variable can be set to true to tell git not to stop
#            at filesystem boundaries. Like GIT_CEILING_DIRECTORIES, this will not affect an explicit repository
#            directory set via GIT_DIR or on the command line.

#    git Commits
#        GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
#        GIT_COMMITTER_DATE, EMAIL
#            see git-commit-tree(1)

#    git Diffs
#        GIT_DIFF_OPTS
#            Only valid setting is "--unified=??" or "-u??" to set the number of context lines shown when a
#            unified diff is created. This takes precedence over any "-U" or "--unified" option value passed on
#            the git diff command line.

#        GIT_EXTERNAL_DIFF
#            When the environment variable GIT_EXTERNAL_DIFF is set, the program named by it is called, instead
#            of the diff invocation described above. For a path that is added, removed, or modified,
#            GIT_EXTERNAL_DIFF is called with 7 parameters:

#                path old-file old-hex old-mode new-file new-hex new-mode

#            where:

#        <old|new>-file
#            are files GIT_EXTERNAL_DIFF can use to read the contents of <old|new>,

#        <old|new>-hex
#            are the 40-hexdigit SHA1 hashes,

#        <old|new>-mode
#            are the octal representation of the file modes.

#            The file parameters can point at the user’s working file (e.g.  new-file in "git-diff-files"),
#            /dev/null (e.g.  old-file when a new file is added), or a temporary file (e.g.  old-file in the
#            index).  GIT_EXTERNAL_DIFF should not worry about unlinking the temporary file --- it is removed
#            when GIT_EXTERNAL_DIFF exits.

#            For a path that is unmerged, GIT_EXTERNAL_DIFF is called with 1 parameter, <path>.

#    other
#        GIT_MERGE_VERBOSITY
#            A number controlling the amount of output shown by the recursive merge strategy. Overrides
#            merge.verbosity. See git-merge(1)

#        GIT_PAGER
#            This environment variable overrides $PAGER. If it is set to an empty string or to the value "cat",
#            git will not launch a pager. See also the core.pager option in git-config(1).

#        GIT_EDITOR
#            This environment variable overrides $EDITOR and $VISUAL. It is used by several git comands when, on
#            interactive mode, an editor is to be launched. See also git-var(1) and the core.editor option in
#            git-config(1).

#        GIT_SSH
#            If this environment variable is set then git fetch and git push will use this command instead of
#            ssh when they need to connect to a remote system. The $GIT_SSH command will be given exactly two
#            arguments: the username@host (or just host) from the URL and the shell command to execute on that
#            remote system.

#            To pass options to the program that you want to list in GIT_SSH you will need to wrap the program
#            and options into a shell script, then set GIT_SSH to refer to the shell script.

#            Usually it is easier to configure any desired options through your personal .ssh/config file.
#            Please consult your ssh documentation for further details.

#        GIT_ASKPASS
#            If this environment variable is set, then git commands which need to acquire passwords or
#            passphrases (e.g. for HTTP or IMAP authentication) will call this program with a suitable prompt as
#            command line argument and read the password from its STDOUT. See also the core.askpass option in
#            git-config(1).

#        GIT_FLUSH
#            If this environment variable is set to "1", then commands such as git blame (in incremental mode),
#            git rev-list, git log, and git whatchanged will force a flush of the output stream after each
#            commit-oriented record have been flushed. If this variable is set to "0", the output of these
#            commands will be done using completely buffered I/O. If this environment variable is not set, git
#            will choose buffered or record-oriented flushing based on whether stdout appears to be redirected
#            to a file or not.

#        GIT_TRACE
#            If this variable is set to "1", "2" or "true" (comparison is case insensitive), git will print
#            trace: messages on stderr telling about alias expansion, built-in command execution and external
#            command execution. If this variable is set to an integer value greater than 1 and lower than 10
#            (strictly) then git will interpret this value as an open file descriptor and will try to write the
#            trace messages into this file descriptor. Alternatively, if this variable is set to an absolute
#            path (starting with a / character), git will interpret this as a file path and will try to write
#            the trace messages into it.

# DISCUSSION
#        More detail on the following is available from the git concepts chapter of the user-manual[3] and
#        gitcore-tutorial(7).

#        A git project normally consists of a working directory with a ".git" subdirectory at the top level. The
#        .git directory contains, among other things, a compressed object database representing the complete
#        history of the project, an "index" file which links that history to the current contents of the working
#        tree, and named pointers into that history such as tags and branch heads.

#        The object database contains objects of three main types: blobs, which hold file data; trees, which
#        point to blobs and other trees to build up directory hierarchies; and commits, which each reference a
#        single tree and some number of parent commits.

#        The commit, equivalent to what other systems call a "changeset" or "version", represents a step in the
#        project’s history, and each parent represents an immediately preceding step. Commits with more than one
#        parent represent merges of independent lines of development.

#        All objects are named by the SHA1 hash of their contents, normally written as a string of 40 hex
#        digits. Such names are globally unique. The entire history leading up to a commit can be vouched for by
#        signing just that commit. A fourth object type, the tag, is provided for this purpose.

#        When first created, objects are stored in individual files, but for efficiency may later be compressed
#        together into "pack files".

#        Named pointers called refs mark interesting points in history. A ref may contain the SHA1 name of an
#        object or the name of another ref. Refs with names beginning ref/head/ contain the SHA1 name of the
#        most recent commit (or "head") of a branch under development. SHA1 names of tags of interest are stored
#        under ref/tags/. A special ref named HEAD contains the name of the currently checked-out branch.

#        The index file is initialized with a list of all paths and, for each path, a blob object and a set of
#        attributes. The blob object represents the contents of the file as of the head of the current branch.
#        The attributes (last modified time, size, etc.) are taken from the corresponding file in the working
#        tree. Subsequent changes to the working tree can be found by comparing these attributes. The index may
#        be updated with new content, and new commits may be created from the content stored in the index.

#        The index is also capable of storing multiple entries (called "stages") for a given pathname. These
#        stages are used to hold the various unmerged version of a file when a merge is in progress.

# AUTHORS
#        Git was started by Linus Torvalds, and is currently maintained by Junio C Hamano. Numerous
#        contributions have come from the git mailing list <git@vger.kernel.org[6]>. For a more complete list of
#        contributors, see http://git-scm.com/about. If you have a clone of git.git itself, the output of git-
#        shortlog(1) and git-blame(1) can show you the authors for specific parts of the project.

# REPORTING BUGS
#        Report bugs to the Git mailing list <git@vger.kernel.org[6]> where the development and maintenance is
#        primarily done. You do not have to be subscribed to the list to send a message there.

# SEE ALSO
#        gittutorial(7), gittutorial-2(7), Everyday Git[1], gitcvs-migration(7), gitglossary(7), gitcore-
#        tutorial(7), gitcli(7), The Git User’s Manual[2], gitworkflows(7)

# GIT
#        Part of the git(1) suite

# NOTES
#         1. Everyday Git
#            file:///usr/share/doc/git/html/everyday.html

#         2. Git User’s Manual
#            file:///usr/share/doc/git/html/user-manual.html

#         3. git concepts chapter of the user-manual
#            file:///usr/share/doc/git/html/user-manual.html#git-concepts

#         4. howto
#            file:///usr/share/doc/git/html/howto-index.html

#         5. GIT API documentation
#            file:///usr/share/doc/git/html/technical/api-index.html

#         6. git@vger.kernel.org
#            mailto:git@vger.kernel.org

# Git 1.7.9.5                                       04/11/2012                                            GIT(1)

### MANPAGE ###
###############GIT-MERGE(1)                                      Git Manual                                      GIT-MERGE(1)


######################
### HELP git-merge ###

# NAME
#        git-merge - Join two or more development histories together

# SYNOPSIS
#        git merge [-n] [--stat] [--no-commit] [--squash]
#                [-s <strategy>] [-X <strategy-option>]
#                [--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
#        git merge <msg> HEAD <commit>...
#        git merge --abort


# DESCRIPTION
#        Incorporates changes from the named commits (since the time their histories diverged from the current
#        branch) into the current branch. This command is used by git pull to incorporate changes from another
#        repository and can be used by hand to merge changes from one branch into another.

#        Assume the following history exists and the current branch is "master":

#                      A---B---C topic
#                     /
#                D---E---F---G master


#        Then "git merge topic" will replay the changes made on the topic branch since it diverged from master
#        (i.e., E) until its current commit (C) on top of master, and record the result in a new commit along
#        with the names of the two parent commits and a log message from the user describing the changes.

#                      A---B---C topic
#                     /         \
#                D---E---F---G---H master


#        The second syntax (<msg> HEAD <commit>...) is supported for historical reasons. Do not use it from the
#        command line or in new scripts. It is the same as git merge -m <msg> <commit>....

#        The third syntax ("git merge --abort") can only be run after the merge has resulted in conflicts. git
#        merge --abort will abort the merge process and try to reconstruct the pre-merge state. However, if
#        there were uncommitted changes when the merge started (and especially if those changes were further
#        modified after the merge was started), git merge --abort will in some cases be unable to reconstruct
#        the original (pre-merge) changes. Therefore:

#        Warning: Running git merge with uncommitted changes is discouraged: while possible, it leaves you in a
#        state that is hard to back out of in the case of a conflict.

# OPTIONS
#        --commit, --no-commit
#            Perform the merge and commit the result. This option can be used to override --no-commit.

#            With --no-commit perform the merge but pretend the merge failed and do not autocommit, to give the
#            user a chance to inspect and further tweak the merge result before committing.

#        --edit, -e
#            Invoke editor before committing successful merge to further edit the default merge message.

#        --ff
#            When the merge resolves as a fast-forward, only update the branch pointer, without creating a merge
#            commit. This is the default behavior.

#        --no-ff
#            Create a merge commit even when the merge resolves as a fast-forward.

#        --ff-only
#            Refuse to merge and exit with a non-zero status unless the current HEAD is already up-to-date or
#            the merge can be resolved as a fast-forward.

#        --log[=<n>], --no-log
#            In addition to branch names, populate the log message with one-line descriptions from at most <n>
#            actual commits that are being merged. See also git-fmt-merge-msg(1).

#            With --no-log do not list one-line descriptions from the actual commits being merged.

#        --stat, -n, --no-stat
#            Show a diffstat at the end of the merge. The diffstat is also controlled by the configuration
#            option merge.stat.

#            With -n or --no-stat do not show a diffstat at the end of the merge.

#        --squash, --no-squash
#            Produce the working tree and index state as if a real merge happened (except for the merge
#            information), but do not actually make a commit or move the HEAD, nor record $GIT_DIR/MERGE_HEAD to
#            cause the next git commit command to create a merge commit. This allows you to create a single
#            commit on top of the current branch whose effect is the same as merging another branch (or more in
#            case of an octopus).

#            With --no-squash perform the merge and commit the result. This option can be used to override
#            --squash.

#        -s <strategy>, --strategy=<strategy>
#            Use the given merge strategy; can be supplied more than once to specify them in the order they
#            should be tried. If there is no -s option, a built-in list of strategies is used instead (git
#            merge-recursive when merging a single head, git merge-octopus otherwise).

#        -X <option>, --strategy-option=<option>
#            Pass merge strategy specific option through to the merge strategy.

#        --summary, --no-summary
#            Synonyms to --stat and --no-stat; these are deprecated and will be removed in the future.

#        -q, --quiet
#            Operate quietly. Implies --no-progress.

#        -v, --verbose
#            Be verbose.

#        --progress, --no-progress
#            Turn progress on/off explicitly. If neither is specified, progress is shown if standard error is
#            connected to a terminal. Note that not all merge strategies may support progress reporting.

#        -m <msg>
#            Set the commit message to be used for the merge commit (in case one is created).

#            If --log is specified, a shortlog of the commits being merged will be appended to the specified
#            message.

#            The git fmt-merge-msg command can be used to give a good default for automated git merge
#            invocations.

#        --rerere-autoupdate, --no-rerere-autoupdate
#            Allow the rerere mechanism to update the index with the result of auto-conflict resolution if
#            possible.

#        --abort
#            Abort the current conflict resolution process, and try to reconstruct the pre-merge state.

#            If there were uncommitted worktree changes present when the merge started, git merge --abort will
#            in some cases be unable to reconstruct these changes. It is therefore recommended to always commit
#            or stash your changes before running git merge.

#            git merge --abort is equivalent to git reset --merge when MERGE_HEAD is present.

#        <commit>...
#            Commits, usually other branch heads, to merge into our branch. Specifying more than one commit will
#            create a merge with more than two parents (affectionately called an Octopus merge).

#            If no commit is given from the command line, and if merge.defaultToUpstream configuration variable
#            is set, merge the remote tracking branches that the current branch is configured to use as its
#            upstream. See also the configuration section of this manual page.

# PRE-MERGE CHECKS
#        Before applying outside changes, you should get your own work in good shape and committed locally, so
#        it will not be clobbered if there are conflicts. See also git-stash(1). git pull and git merge will
#        stop without doing anything when local uncommitted changes overlap with files that git pull/git merge
#        may need to update.

#        To avoid recording unrelated changes in the merge commit, git pull and git merge will also abort if
#        there are any changes registered in the index relative to the HEAD commit. (One exception is when the
#        changed index entries are in the state that would result from the merge already.)

#        If all named commits are already ancestors of HEAD, git merge will exit early with the message "Already
#        up-to-date."

# FAST-FORWARD MERGE
#        Often the current branch head is an ancestor of the named commit. This is the most common case
#        especially when invoked from git pull: you are tracking an upstream repository, you have committed no
#        local changes, and now you want to update to a newer upstream revision. In this case, a new commit is
#        not needed to store the combined history; instead, the HEAD (along with the index) is updated to point
#        at the named commit, without creating an extra merge commit.

#        This behavior can be suppressed with the --no-ff option.

# TRUE MERGE
#        Except in a fast-forward merge (see above), the branches to be merged must be tied together by a merge
#        commit that has both of them as its parents.

#        A merged version reconciling the changes from all branches to be merged is committed, and your HEAD,
#        index, and working tree are updated to it. It is possible to have modifications in the working tree as
#        long as they do not overlap; the update will preserve them.

#        When it is not obvious how to reconcile the changes, the following happens:

#         1. The HEAD pointer stays the same.

#         2. The MERGE_HEAD ref is set to point to the other branch head.

#         3. Paths that merged cleanly are updated both in the index file and in your working tree.

#         4. For conflicting paths, the index file records up to three versions: stage 1 stores the version from
#            the common ancestor, stage 2 from HEAD, and stage 3 from MERGE_HEAD (you can inspect the stages
#            with git ls-files -u). The working tree files contain the result of the "merge" program; i.e. 3-way
#            merge results with familiar conflict markers <<< === >>>.

#         5. No other changes are made. In particular, the local modifications you had before you started merge
#            will stay the same and the index entries for them stay as they were, i.e. matching HEAD.

#        If you tried a merge which resulted in complex conflicts and want to start over, you can recover with
#        git merge --abort.

# HOW CONFLICTS ARE PRESENTED
#        During a merge, the working tree files are updated to reflect the result of the merge. Among the
#        changes made to the common ancestor’s version, non-overlapping ones (that is, you changed an area of
#        the file while the other side left that area intact, or vice versa) are incorporated in the final
#        result verbatim. When both sides made changes to the same area, however, git cannot randomly pick one
#        side over the other, and asks you to resolve it by leaving what both sides did to that area.

#        By default, git uses the same style as that is used by "merge" program from the RCS suite to present
#        such a conflicted hunk, like this:

#            Here are lines that are either unchanged from the common
#            ancestor, or cleanly resolved because only one side changed.
#            <<<<<<< yours:sample.txt
#            Conflict resolution is hard;
#            let's go shopping.
#            =======
#            Git makes conflict resolution easy.
#            >>>>>>> theirs:sample.txt
#            And here is another line that is cleanly resolved or unmodified.


#        The area where a pair of conflicting changes happened is marked with markers <<<<<<<, =======, and
#        >>>>>>>. The part before the ======= is typically your side, and the part afterwards is typically their
#        side.

#        The default format does not show what the original said in the conflicting area. You cannot tell how
#        many lines are deleted and replaced with Barbie’s remark on your side. The only thing you can tell is
#        that your side wants to say it is hard and you’d prefer to go shopping, while the other side wants to
#        claim it is easy.

#        An alternative style can be used by setting the "merge.conflictstyle" configuration variable to
#        "diff3". In "diff3" style, the above conflict may look like this:

#            Here are lines that are either unchanged from the common
#            ancestor, or cleanly resolved because only one side changed.
#            <<<<<<< yours:sample.txt
#            Conflict resolution is hard;
#            let's go shopping.
#            |||||||
#            Conflict resolution is hard.
#            =======
#            Git makes conflict resolution easy.
#            >>>>>>> theirs:sample.txt
#            And here is another line that is cleanly resolved or unmodified.


#        In addition to the <<<<<<<, =======, and >>>>>>> markers, it uses another ||||||| marker that is
#        followed by the original text. You can tell that the original just stated a fact, and your side simply
#        gave in to that statement and gave up, while the other side tried to have a more positive attitude. You
#        can sometimes come up with a better resolution by viewing the original.

# HOW TO RESOLVE CONFLICTS
#        After seeing a conflict, you can do two things:

#        ·   Decide not to merge. The only clean-ups you need are to reset the index file to the HEAD commit to
#            reverse 2. and to clean up working tree changes made by 2. and 3.; git merge --abort can be used
#            for this.

#        ·   Resolve the conflicts. Git will mark the conflicts in the working tree. Edit the files into shape
#            and git add them to the index. Use git commit to seal the deal.

#        You can work through the conflict with a number of tools:

#        ·   Use a mergetool.  git mergetool to launch a graphical mergetool which will work you through the
#            merge.

#        ·   Look at the diffs.  git diff will show a three-way diff, highlighting changes from both the HEAD
#            and MERGE_HEAD versions.

#        ·   Look at the diffs from each branch.  git log --merge -p <path> will show diffs first for the HEAD
#            version and then the MERGE_HEAD version.

#        ·   Look at the originals.  git show :1:filename shows the common ancestor, git show :2:filename shows
#            the HEAD version, and git show :3:filename shows the MERGE_HEAD version.

# EXAMPLES
#        ·   Merge branches fixes and enhancements on top of the current branch, making an octopus merge:

#                $ git merge fixes enhancements


#        ·   Merge branch obsolete into the current branch, using ours merge strategy:

#                $ git merge -s ours obsolete


#        ·   Merge branch maint into the current branch, but do not make a new commit automatically:

#                $ git merge --no-commit maint

#            This can be used when you want to include further changes to the merge, or want to write your own
#            merge commit message.

#            You should refrain from abusing this option to sneak substantial changes into a merge commit. Small
#            fixups like bumping release/version name would be acceptable.

# MERGE STRATEGIES
#        The merge mechanism (git-merge and git-pull commands) allows the backend merge strategies to be chosen
#        with -s option. Some strategies can also take their own options, which can be passed by giving
#        -X<option> arguments to git-merge and/or git-pull.

#        resolve
#            This can only resolve two heads (i.e. the current branch and another branch you pulled from) using
#            a 3-way merge algorithm. It tries to carefully detect criss-cross merge ambiguities and is
#            considered generally safe and fast.

#        recursive
#            This can only resolve two heads using a 3-way merge algorithm. When there is more than one common
#            ancestor that can be used for 3-way merge, it creates a merged tree of the common ancestors and
#            uses that as the reference tree for the 3-way merge. This has been reported to result in fewer
#            merge conflicts without causing mis-merges by tests done on actual merge commits taken from Linux
#            2.6 kernel development history. Additionally this can detect and handle merges involving renames.
#            This is the default merge strategy when pulling or merging one branch.

#            The recursive strategy can take the following options:

#            ours
#                This option forces conflicting hunks to be auto-resolved cleanly by favoring our version.
#                Changes from the other tree that do not conflict with our side are reflected to the merge
#                result.

#                This should not be confused with the ours merge strategy, which does not even look at what the
#                other tree contains at all. It discards everything the other tree did, declaring our history
#                contains all that happened in it.

#            theirs
#                This is opposite of ours.

#            patience
#                With this option, merge-recursive spends a little extra time to avoid mismerges that sometimes
#                occur due to unimportant matching lines (e.g., braces from distinct functions). Use this when
#                the branches to be merged have diverged wildly. See also git-diff(1) --patience.

#            ignore-space-change, ignore-all-space, ignore-space-at-eol
#                Treats lines with the indicated type of whitespace change as unchanged for the sake of a
#                three-way merge. Whitespace changes mixed with other changes to a line are not ignored. See
#                also git-diff(1) -b, -w, and --ignore-space-at-eol.

#                ·   If their version only introduces whitespace changes to a line, our version is used;

#                ·   If our version introduces whitespace changes but their version includes a substantial
#                    change, their version is used;

#                ·   Otherwise, the merge proceeds in the usual way.

#            renormalize
#                This runs a virtual check-out and check-in of all three stages of a file when resolving a
#                three-way merge. This option is meant to be used when merging branches with different clean
#                filters or end-of-line normalization rules. See "Merging branches with differing
#                checkin/checkout attributes" in gitattributes(5) for details.

#            no-renormalize
#                Disables the renormalize option. This overrides the merge.renormalize configuration variable.

#            rename-threshold=<n>
#                Controls the similarity threshold used for rename detection. See also git-diff(1) -M.

#            subtree[=<path>]
#                This option is a more advanced form of subtree strategy, where the strategy makes a guess on
#                how two trees must be shifted to match with each other when merging. Instead, the specified
#                path is prefixed (or stripped from the beginning) to make the shape of two trees to match.

#        octopus
#            This resolves cases with more than two heads, but refuses to do a complex merge that needs manual
#            resolution. It is primarily meant to be used for bundling topic branch heads together. This is the
#            default merge strategy when pulling or merging more than one branch.

#        ours
#            This resolves any number of heads, but the resulting tree of the merge is always that of the
#            current branch head, effectively ignoring all changes from all other branches. It is meant to be
#            used to supersede old development history of side branches. Note that this is different from the
#            -Xours option to the recursive merge strategy.

#        subtree
#            This is a modified recursive strategy. When merging trees A and B, if B corresponds to a subtree of
#            A, B is first adjusted to match the tree structure of A, instead of reading the trees at the same
#            level. This adjustment is also done to the common ancestor tree.

# CONFIGURATION
#        merge.conflictstyle
#            Specify the style in which conflicted hunks are written out to working tree files upon merge. The
#            default is "merge", which shows a <<<<<<< conflict marker, changes made by one side, a =======
#            marker, changes made by the other side, and then a >>>>>>> marker. An alternate style, "diff3",
#            adds a ||||||| marker and the original text before the ======= marker.

#        merge.defaultToUpstream
#            If merge is called without any commit argument, merge the upstream branches configured for the
#            current branch by using their last observed values stored in their remote tracking branches. The
#            values of the branch.<current branch>.merge that name the branches at the remote named by
#            branch.<current branch>.remote are consulted, and then they are mapped via remote.<remote>.fetch to
#            their corresponding remote tracking branches, and the tips of these tracking branches are merged.

#        merge.ff
#            By default, git does not create an extra merge commit when merging a commit that is a descendant of
#            the current commit. Instead, the tip of the current branch is fast-forwarded. When set to false,
#            this variable tells git to create an extra merge commit in such a case (equivalent to giving the
#            --no-ff option from the command line). When set to only, only such fast-forward merges are allowed
#            (equivalent to giving the --ff-only option from the command line).

#        merge.log
#            In addition to branch names, populate the log message with at most the specified number of one-line
#            descriptions from the actual commits that are being merged. Defaults to false, and true is a
#            synonym for 20.

#        merge.renameLimit
#            The number of files to consider when performing rename detection during a merge; if not specified,
#            defaults to the value of diff.renameLimit.

#        merge.renormalize
#            Tell git that canonical representation of files in the repository has changed over time (e.g.
#            earlier commits record text files with CRLF line endings, but recent ones use LF line endings). In
#            such a repository, git can convert the data recorded in commits to a canonical form before
#            performing a merge to reduce unnecessary conflicts. For more information, see section "Merging
#            branches with differing checkin/checkout attributes" in gitattributes(5).

#        merge.stat
#            Whether to print the diffstat between ORIG_HEAD and the merge result at the end of the merge. True
#            by default.

#        merge.tool
#            Controls which merge resolution program is used by git-mergetool(1). Valid built-in values are:
#            "araxis", "bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld", "opendiff",
#            "p4merge", "tkdiff", "tortoisemerge", "vimdiff" and "xxdiff". Any other value is treated is custom
#            merge tool and there must be a corresponding mergetool.<tool>.cmd option.

#        merge.verbosity
#            Controls the amount of output shown by the recursive merge strategy. Level 0 outputs nothing except
#            a final error message if conflicts were detected. Level 1 outputs only conflicts, 2 outputs
#            conflicts and file changes. Level 5 and above outputs debugging information. The default is level
#            2. Can be overridden by the GIT_MERGE_VERBOSITY environment variable.

#        merge.<driver>.name
#            Defines a human-readable name for a custom low-level merge driver. See gitattributes(5) for
#            details.

#        merge.<driver>.driver
#            Defines the command that implements a custom low-level merge driver. See gitattributes(5) for
#            details.

#        merge.<driver>.recursive
#            Names a low-level merge driver to be used when performing an internal merge between common
#            ancestors. See gitattributes(5) for details.

#        branch.<name>.mergeoptions
#            Sets default options for merging into branch <name>. The syntax and supported options are the same
#            as those of git merge, but option values containing whitespace characters are currently not
#            supported.

# SEE ALSO
#        git-fmt-merge-msg(1), git-pull(1), gitattributes(5), git-reset(1), git-diff(1), git-ls-files(1), git-
#        add(1), git-rm(1), git-mergetool(1)

# GIT
#        Part of the git(1) suite


# Git 1.7.9.5                                       04/11/2012                                      GIT-MERGE(1)

### HELP git-merge ###
######################

#######################
### HELP git-remote ###

# GIT-REMOTE(1)                                     Git Manual                                     GIT-REMOTE(1)

# NAME
#        git-remote - manage set of tracked repositories

# SYNOPSIS
#        git remote [-v | --verbose]
#        git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>
#        git remote rename <old> <new>
#        git remote rm <name>
#        git remote set-head <name> (-a | -d | <branch>)
#        git remote set-branches [--add] <name> <branch>...
#        git remote set-url [--push] <name> <newurl> [<oldurl>]
#        git remote set-url --add [--push] <name> <newurl>
#        git remote set-url --delete [--push] <name> <url>
#        git remote [-v | --verbose] show [-n] <name>
#        git remote prune [-n | --dry-run] <name>
#        git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]


# DESCRIPTION
#        Manage the set of repositories ("remotes") whose branches you track.

# OPTIONS
#        -v, --verbose
#            Be a little more verbose and show remote url after name. NOTE: This must be placed between remote
#            and subcommand.

# COMMANDS
#        With no arguments, shows a list of existing remotes. Several subcommands are available to perform
#        operations on the remotes.

#        add
#            Adds a remote named <name> for the repository at <url>. The command git fetch <name> can then be
#            used to create and update remote-tracking branches <name>/<branch>.

#            With -f option, git fetch <name> is run immediately after the remote information is set up.

#            With --tags option, git fetch <name> imports every tag from the remote repository.

#            With --no-tags option, git fetch <name> does not import tags from the remote repository.

#            With -t <branch> option, instead of the default glob refspec for the remote to track all branches
#            under the refs/remotes/<name>/ namespace, a refspec to track only <branch> is created. You can give
#            more than one -t <branch> to track multiple branches without grabbing all branches.

#            With -m <master> option, a symbolic-ref refs/remotes/<name>/HEAD is set up to point at remote’s
#            <master> branch. See also the set-head command.

#            When a fetch mirror is created with --mirror=fetch, the refs will not be stored in the
#            refs/remotes/ namespace, but rather everything in refs/ on the remote will be directly mirrored
#            into refs/ in the local repository. This option only makes sense in bare repositories, because a
#            fetch would overwrite any local commits.

#            When a push mirror is created with --mirror=push, then git push will always behave as if --mirror
#            was passed.

#        rename
#            Rename the remote named <old> to <new>. All remote-tracking branches and configuration settings for
#            the remote are updated.

#            In case <old> and <new> are the same, and <old> is a file under $GIT_DIR/remotes or
#            $GIT_DIR/branches, the remote is converted to the configuration file format.

#        rm
#            Remove the remote named <name>. All remote-tracking branches and configuration settings for the
#            remote are removed.

#        set-head
#            Sets or deletes the default branch (i.e. the target of the symbolic-ref refs/remotes/<name>/HEAD)
#            for the named remote. Having a default branch for a remote is not required, but allows the name of
#            the remote to be specified in lieu of a specific branch. For example, if the default branch for
#            origin is set to master, then origin may be specified wherever you would normally specify
#            origin/master.

#            With -d, the symbolic ref refs/remotes/<name>/HEAD is deleted.

#            With -a, the remote is queried to determine its HEAD, then the symbolic-ref
#            refs/remotes/<name>/HEAD is set to the same branch. e.g., if the remote HEAD is pointed at next,
#            "git remote set-head origin -a" will set the symbolic-ref refs/remotes/origin/HEAD to
#            refs/remotes/origin/next. This will only work if refs/remotes/origin/next already exists; if not it
#            must be fetched first.

#            Use <branch> to set the symbolic-ref refs/remotes/<name>/HEAD explicitly. e.g., "git remote
#            set-head origin master" will set the symbolic-ref refs/remotes/origin/HEAD to
#            refs/remotes/origin/master. This will only work if refs/remotes/origin/master already exists; if
#            not it must be fetched first.

#        set-branches
#            Changes the list of branches tracked by the named remote. This can be used to track a subset of the
#            available remote branches after the initial setup for a remote.

#            The named branches will be interpreted as if specified with the -t option on the git remote add
#            command line.

#            With --add, instead of replacing the list of currently tracked branches, adds to that list.

#        set-url
#            Changes URL remote points to. Sets first URL remote points to matching regex <oldurl> (first URL if
#            no <oldurl> is given) to <newurl>. If <oldurl> doesn’t match any URL, error occurs and nothing is
#            changed.

#            With --push, push URLs are manipulated instead of fetch URLs.

#            With --add, instead of changing some URL, new URL is added.

#            With --delete, instead of changing some URL, all URLs matching regex <url> are deleted. Trying to
#            delete all non-push URLs is an error.

#        show
#            Gives some information about the remote <name>.

#            With -n option, the remote heads are not queried first with git ls-remote <name>; cached
#            information is used instead.

#        prune
#            Deletes all stale remote-tracking branches under <name>. These stale branches have already been
#            removed from the remote repository referenced by <name>, but are still locally available in
#            "remotes/<name>".

#            With --dry-run option, report what branches will be pruned, but do not actually prune them.

#        update
#            Fetch updates for a named set of remotes in the repository as defined by remotes.<group>. If a
#            named group is not specified on the command line, the configuration parameter remotes.default will
#            be used; if remotes.default is not defined, all remotes which do not have the configuration
#            parameter remote.<name>.skipDefaultUpdate set to true will be updated. (See git-config(1)).

#            With --prune option, prune all the remotes that are updated.

# DISCUSSION
#        The remote configuration is achieved using the remote.origin.url and remote.origin.fetch configuration
#        variables. (See git-config(1)).

# EXAMPLES
#    Add a new remote, fetch, and check out a branch from it
#    $ git remote origin
#    $ git branch -r origin/master
#    $ git remote add linux-nfs git://linux-nfs.org/pub/linux/nfs-2.6.git
#    $ git remote linux-nfs origin
#    $ git fetch * refs/remotes/linux-nfs/master: storing branch 'master' ...
#      commit: bf81b46
#    $ git branch -r origin/master linux-nfs/master
#    $ git checkout -b nfs linux-nfs/master

#    Imitate git clone but track only selected branches
#    $ mkdir project.git
#    $ cd project.git
#    $ git init
#    $ git remote add -f -t master -m master origin git://example.com/git.git/
#    $ git merge origin


# SEE ALSO
#        git-fetch(1) git-branch(1) git-config(1)

# GIT
#        Part of the git(1) suite

# Git 1.7.9.5                                       04/11/2012                                     GIT-REMOTE(1)

### HELP git-remote ###
#######################
