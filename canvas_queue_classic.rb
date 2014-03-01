#!/usr/bin/ruby -w
# canvas_queue_classic.rb
# Author: Andy Bettisworth
# Description: Canvas Queue Classic gem; a job queueing system
require 'queue_classic'

## QUEUE 'default'
# sending massive newsletters
# image resizing
# http downloads
# updating smart collections
# updating solr, our search server, after product changes
# batch imports
# spam checks
# generating invoices once a month on the 1st
# send reminder emails on a nightly basis
# refreshing feeds on an hourly basis

## QUEUE 'routine'
# sync Annex
# rotate background
# source .bashrc
# clean /Desktop, /tmp, /Downloads

## FEATURES
# Leverage of PostgreSQL's listen/notify & row locking.
# SUpport for multiple queues with heterogeneous workers.
# JSON data schema_formatForking workers.
# Workers can work multiple queues.
# Forking workers.
# Workers can work multiple queues.
# Reduced row contention using a relaxed FIFO technique.

## Methods
#  Producing Jobs
#  Working Jobs

## EXEC ruby script file
# QC::Queue.new('routine').enqueue("Kernel.load", "/home/wurde/test.rb")
# QC::Worker.new(q_name: 'routine').start

##########################
### COMMAND-LINE USAGE ###
## CREATE a job
# ruby -r queue_classic -e "QC.enqueue('puts', 'Testing 1 2 3')"

## EXEC one job
# ruby -r queue_classic -e "QC::Worker.new.work"

## EXEC all jobs
# ruby -r queue_classic -e "QC::Worker.new.start"
### COMMAND-LINE USAGE ###
##########################

## QC::Worker.new(args={}) arguments
  # fork_worker::   Worker forks each job execution.
  # wait_interval:: Time to wait between failed lock attempts
  # connection::    PGConn object.
  # q_name::        Name of a single queue to process.
  # q_names::       Names of queues to process. Will process left to right.
  # top_bound::     Offset to the head of the queue. 1 == strict FIFO.

######################
### PRODUCING JOBS ###
# This method has no arguments.
# QC.enqueue("Time.now")
# # This method has 1 argument.
# QC.enqueue("Kernel.puts", "hello world")
# # This method has 2 arguments.
# QC.enqueue("Kernel.printf", "hello %s", "world")
# # This method has a hash argument.
# QC.enqueue("Kernel.puts", {"hello" => "world"})
# # This method has an array argument.
# QC.enqueue("Kernel.puts", ["hello", "world"])
# QC::Worker.new.start
#
# # This method uses a non-default queue.
# p_queue = QC::Queue.new("priority_queue")
# p_queue.enqueue("Kernel.puts", ["hello", "world"])
### PRODUCING JOBS ###
######################

## Q: How to execute a custom queue
## a: set target queue on QC::Worker instance
# worker = QC::Worker.new
# worker.queue = 'priority_queue'
# worker.work
## ~OR~
# QC::Worker.new(q_name: 'priority_queue').start

#####################
### CUSTOM WORKER ###
# require 'timeout'
# require 'queue_classic'

# FailedQueue = QC::Queue.new("failed_jobs")

# class MyWorker < QC::Worker
#   def handle_failure(job, e)
#    FailedQueue.enqueue(job[:method], *job[:args])
#   end
# end

# worker = MyWorker.new

# trap('INT') { exit }
# trap('TERM') { worker.stop }

# loop do
#   job = worker.lock_job
#   Timeout::timeout(5) { worker.process(job) }
# end
### CUSTOM WORKER ###
#####################

#######################
### BOOTSTRAP SETUP ###
# require 'active_record'
# require 'pg'
# require 'queue_classic'

# ActiveRecord::Base.establish_connection(
#   adapter: 'postgresql',
#   host: 'localhost',
#   database: 'queue_classic',
#   username: 'wurde',
#   password: 'trichoderma')

# class AddQueueClassic < ActiveRecord::Migration
#   def self.up
#     QC::Setup.create
#   end
#   def self.down
#     QC::Setup.drop
#   end
# end
# AddQueueClassic.up
### BOOTSTRAP SETUP ###
#######################

###################
### QUICK START ###
# gem install queue_classic
# createdb queue_classic_test
# export QC_DATABASE_URL="postgres://wurde:trichoderma@localhost/queue_classic_test"
# ruby -r queue_classic -e "QC::Setup.create"
# ruby -r queue_classic -e "QC.enqueue('Kernel.puts', 'Testing 1 2 3')"
# ruby -r queue_classic -e "QC::Worker.new.work"
### QUICK START ###
###################

###################
### SETUP RAILS ###
## [Gemfile]
# gem "queue_classic", "3.0.0beta"

## EXEC
# rails generate queue_classic:install
# rake db:migrate

## SET URL
# By default, queue_classic will use the QC_DATABASE_URL falling back on DATABASE_URL
# postgres://username:password@localhost/database_name

## SET config
# [config/application.rb]
# config.active_record.schema_format = :sql
### SETUP RAILS ###
###################

####################
### Working jobs ###

## NOTE
# There are two ways to work jobs; rake task & custom executable.

  ## Rake task:
  # Require queue_classic in your Rakefile.
    # require 'queue_classic'
    # require 'queue_classic/tasks'
  # Start the worker via the Rakefile.
    # $ bundle exec rake qc:work
  # Setup a worker to work a non-default queue.
    # $ QUEUE="priority_queue" bundle exec rake qc:work
  # Setup a worker to work multiple queues.
    # $ QUEUES="priority_queue, secondary_queue" bundle exec rake qc:work
  # In this scenario, on each iteration of the worker's loop,
  # it will look for jobs in the first queue prior to looking
  # at the second queue. This means that the first queue must be
  # empty before the worker will look at the second queue.
  ## Custom executable:

## Class: QC
# (from gem queue_classic-2.2.3)
# ------------------------------------------------------------------------------
## Constants

# APP_NAME:
#   You can use the APP_NAME to query for postgres related process information
#   in the pg_stat_activity table.

# FORK_WORKER:
#   Set this variable if you wish for the worker to fork a UNIX process for each locked job.
#   Remember to re-establish any database connections. See the worker for more details.

# QUEUE:
#   Each row in the table will have a column that notes the queue. You can point your workers at different queues but only one at a time.

# TABLE_NAME:
#   Why do you want to change the table name? Just deal with the default OK? If
#   you do want to change this, you will need to update the PL/pgSQL lock_head() function. Come on. Don't do it.... Just stick with the default.

# TOP_BOUND:
#   Set this to 1 for strict FIFO. There is nothing special about 9....

# WAIT_TIME:
#   Number of seconds to block on the listen chanel for new jobs.

## Class methods
  # default_queue
  # default_queue=
  # log
  # log_yield
  # method_missing
  # respond_to_missing?

## QC::Worker < Object
# (from gem queue_classic-2.2.3)
# ------------------------------------------------------------------------------
## Class methods
#   new

## Instance methods
#   call
#   fork_and_work
#   handle_failure
#   lock_job
#   log
#   process
#   queue
#   running
#   setup_child
#   start
#   stop
#   work

## Attributes
#   attr_accessor queue
#   attr_accessor running

# = QC::Worker.call
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   call(job)
# ------------------------------------------------------------------------------
# Each job includes a method column. We will use ruby's eval to grab the ruby
# object from memory. We send the method to the object and pass the args.

# = QC::Worker.fork_and_work
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   fork_and_work()
# ------------------------------------------------------------------------------
# This method will tell the ruby process to FORK. Define setup_child to hook
# into the forking process. Using setup_child is good for re-establishing
# database connections.

# = QC::Worker.handle_failure
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   handle_failure(job,e)
# ------------------------------------------------------------------------------
# This method will be called when an exception is raised during the execution of
# the job.


# = QC::Worker.lock_job
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   lock_job()
# ------------------------------------------------------------------------------
# Attempt to lock a job in the queue's table. Return a hash when a job is
# locked. Caller responsible for deleting the job when finished.


# = QC::Worker.process
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   process(job)
# ------------------------------------------------------------------------------
# A job is processed by evaluating the target code. Errors are delegated to the
# handle_failure method. Also, this method will make the best attempt to delete
# the job from the queue before returning.


# = QC::Worker.setup_child
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   setup_child()
# ------------------------------------------------------------------------------
# This method should be overriden if your worker is forking and you need to
# re-establish database connections


# = QC::Worker.start
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   start()
# ------------------------------------------------------------------------------
# Start a loop and work jobs indefinitely. Call this method to start the worker.
# This is the easiest way to start working jobs.


# = QC::Worker.stop
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   stop()
# ------------------------------------------------------------------------------
# Call this method to stop the worker. The worker may not stop immediately if
# the worker is sleeping.


# = QC::Worker.work
# (from gem queue_classic-2.2.3)
# === Implementation from Worker
# ------------------------------------------------------------------------------
#   work()
# ------------------------------------------------------------------------------
# This method will lock a job & process the job.

