#!/usr/bin/ruby -w
# canvas_process.rb
# Author: Andy Bettisworth
# Description: Canvas Process class

# = PPrroocceessss

# (from ruby core)
# ------------------------------------------------------------------------------
# The Process module is a collection of methods used to manipulate processes.
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# CLOCK_BOOTTIME:
#   [not documented]

# CLOCK_BOOTTIME_ALARM:
#   [not documented]

# CLOCK_MONOTONIC:
#   [not documented]

# CLOCK_MONOTONIC_COARSE:
#   [not documented]

# CLOCK_MONOTONIC_FAST:
#   [not documented]

# CLOCK_MONOTONIC_PRECISE:
#   [not documented]

# CLOCK_MONOTONIC_RAW:
#   [not documented]

# CLOCK_PROCESS_CPUTIME_ID:
#   [not documented]

# CLOCK_PROF:
#   [not documented]

# CLOCK_REALTIME:
#   [not documented]

# CLOCK_REALTIME_ALARM:
#   [not documented]

# CLOCK_REALTIME_COARSE:
#   [not documented]

# CLOCK_REALTIME_FAST:
#   [not documented]

# CLOCK_REALTIME_PRECISE:
#   [not documented]

# CLOCK_SECOND:
#   [not documented]

# CLOCK_THREAD_CPUTIME_ID:
#   [not documented]

# CLOCK_UPTIME:
#   [not documented]

# CLOCK_UPTIME_FAST:
#   [not documented]

# CLOCK_UPTIME_PRECISE:
#   [not documented]

# CLOCK_VIRTUAL:
#   [not documented]

# PRIO_PGRP:
#   see Process.setpriority


# PRIO_PROCESS:
#   see Process.setpriority


# PRIO_USER:
#   see Process.setpriority


# RLIMIT_AS:
#   Maximum size of the process's virtual memory (address space) in bytes.

#   see the system getrlimit(2) manual for details.

# RLIMIT_CORE:
#   Maximum size of the core file.

#   see the system getrlimit(2) manual for details.

# RLIMIT_CPU:
#   CPU time limit in seconds.

#   see the system getrlimit(2) manual for details.

# RLIMIT_DATA:
#   Maximum size of the process's data segment.

#   see the system getrlimit(2) manual for details.

# RLIMIT_FSIZE:
#   Maximum size of files that the process may create.

#   see the system getrlimit(2) manual for details.

# RLIMIT_MEMLOCK:
#   Maximum number of bytes of memory that may be locked into RAM.

#   see the system getrlimit(2) manual for details.

# RLIMIT_MSGQUEUE:
#   Specifies the limit on the number of bytes that can be allocated for POSIX
#   message queues for the real user ID of the calling process.

#   see the system getrlimit(2) manual for details.

# RLIMIT_NICE:
#   Specifies a ceiling to which the process's nice value can be raised.

#   see the system getrlimit(2) manual for details.

# RLIMIT_NOFILE:
#   Specifies a value one greater than the maximum file descriptor number that
#   can be opened by this process.

#   see the system getrlimit(2) manual for details.

# RLIMIT_NPROC:
#   The maximum number of processes that can be created for the real user ID of
#   the calling process.

#   see the system getrlimit(2) manual for details.

# RLIMIT_RSS:
#   Specifies the limit (in pages) of the process's resident set.

#   see the system getrlimit(2) manual for details.

# RLIMIT_RTPRIO:
#   Specifies a ceiling on the real-time priority that may be set for this
#   process.

#   see the system getrlimit(2) manual for details.

# RLIMIT_RTTIME:
#   Specifies limit on CPU time this process scheduled under a real-time
#   scheduling policy can consume.

#   see the system getrlimit(2) manual for details.

# RLIMIT_SBSIZE:
#   Maximum size of the socket buffer.

# RLIMIT_SIGPENDING:
#   Specifies a limit on the number of signals that may be queued for the real
#   user ID of the calling process.

#   see the system getrlimit(2) manual for details.

# RLIMIT_STACK:
#   Maximum size of the stack, in bytes.

#   see the system getrlimit(2) manual for details.

# RLIM_INFINITY:
#   see Process.setrlimit


# RLIM_SAVED_CUR:
#   see Process.setrlimit


# RLIM_SAVED_MAX:
#   see Process.setrlimit


# WNOHANG:
#   see Process.wait


# WUNTRACED:
#   see Process.wait



# = CCllaassss  mmeetthhooddss::

#   abort
#   argv0
#   clock_getres
#   clock_gettime
#   daemon
#   detach
#   egid
#   egid=
#   euid
#   euid=
#   exec
#   exit
#   exit!
#   fork
#   getpgid
#   getpgrp
#   getpriority
#   getrlimit
#   getsid
#   gid
#   gid=
#   groups
#   groups=
#   initgroups
#   kill
#   maxgroups
#   maxgroups=
#   pid
#   ppid
#   setpgid
#   setpgrp
#   setpriority
#   setproctitle
#   setrlimit
#   setsid
#   spawn
#   times
#   uid
#   uid=
#   wait
#   wait2
#   waitall
#   waitpid
#   waitpid2

# (from gem main-5.2.0)
# ------------------------------------------------------------------------------
# = IInnssttaannccee  mmeetthhooddss::

#   abort

# ------------------------------------------------------------------------------
# Also found in:
#   gem activesupport-4.0.2

