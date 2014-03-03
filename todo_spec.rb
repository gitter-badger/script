#!/usr/bin/ruby -w
# todo_spec.rb
# Description: task management

class TODO
  DEFAULT_LIST = ENV['HOME'] + '/default.tasks'

  def new(options)
    task = options[:task]
    list = DEFAULT_LIST
    unless options[:list].nil?
      list = options[:list]
    end
    line_number = 0
    File.open(list,'w+') do |file|
      file.puts line_number.to_s + " " + task
      line_number += 1
    end
  end

  def list(list = DEFAULT_LIST)
    File.new(list,'r').readlines
  end

  def update(options)
    task = options[:task]
    update = options[:update]
    list = DEFAULT_LIST
    unless options[:list].nil?
      list = options[:list]
    end
    transfer_file = String.new
    old_file = File.open(list,"r")
    old_file.each_with_index do |line, index|
      unless index == task
        transfer_file << line
      else
        transfer_file << update
      end
    end
    old_file.close
    new_file = File.open(list,"w")
    new_file.write(transfer_file)
    new_file.close
  end

  def done(options)
    task = options[:task]
    list = DEFAULT_LIST
    unless options[:list].nil?
      list = options[:list]
    end
    transfer_file = String.new
    old_file = File.open(list,"r")
    old_file.each_with_index do |line, index|
      unless index == task
        transfer_file << line
      else
        transfer_file << "[DONE] " + line
      end
    end
    old_file.close
    new_file = File.open(list,"w")
    new_file.write(transfer_file)
    new_file.close
  end

  def delete(options)
    task = options[:task]
    list = DEFAULT_LIST
    unless options[:list].nil?
      list = options[:list]
    end
    transfer_file = String.new
    old_file = File.open(list,"r")
    old_file.each_with_index do |line, index|
      unless index == task
        transfer_file << line
      end
    end
    old_file.close
    new_file = File.open(list,"w")
    new_file.write(transfer_file)
    new_file.close
  end

  def delete_all(options)
    task = options[:task]
    list = DEFAULT_LIST
    unless options[:list].nil?
      list = options[:list]
    end
    File.open(list,'w+')
  end
end

## USAGE
# todo new "write to-do specification"
# todo -f ~/.rbscript/_idea/todo_spec.tasks new "review"
# todo list -s name
# todo update 3 "write task specification"
# todo done 3

describe TODO do
  let(:taskmaster) { TODO.new }
  let(:default_list) { ENV['HOME'] + '/default.tasks' }
  let(:target_list) { ENV['HOME'] + '/Desktop/task/task.tasks' }
  let(:test_task) { "write to-do specification" }
  let(:target_task) { 0 }
  let(:update_task) { "use rspec to write tests for infinite loops" }

  before(:each) do
    File.delete(default_list) if File.exist?(default_list)
    File.delete(target_list) if File.exist?(target_list)
    File.new(default_list,'w+')
    File.new(target_list,'w+')
  end

  def find_task(options)
    task = options[:task]
    regex = options[:regex]
    list = default_list
    unless options[:list].nil?
      list = options[:list]
    end
    found_file = false
    File.open(list,'r').readlines.each_with_index do |line,index|
      found_file ||= line =~ regex
    end
    return found_file
  end

  describe "#new" do
    context "using default list" do
      it "should create a new to-do in default list" do
        taskmaster.new(task: test_task, list: default_list)
        expect(find_task(list: default_list, regex: /#{test_task}/o)).to_not be_nil
      end
    end
    context "using default list" do
      it "should create a new to-do in target list" do
        taskmaster.new(task: test_task, list: target_list)
        expect(find_task(list: target_list, regex: /#{test_task}/o)).to_not be_nil
      end
    end
  end

  describe "#list" do
    context "using default list" do
      it "should print all to-dos in list" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.list
        expect(find_task(list: default_list, regex: /^\d.*/)).to_not be_nil
      end
      it "should NOT display done to-dos" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.list
        expect(find_task(list: default_list, regex: /^\[TODO\]/)).to be_false
      end
    end

    context "using target list" do
      it "should print all to-dos in list" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.list(target_list)
        expect(find_task(list: target_list, regex: /^\d.*/)).to_not be_nil
      end
      it "should NOT display done to-dos" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.list
        expect(find_task(list: target_list, regex: /^\[TODO\]/)).to be_false
      end
    end
  end

  describe "#update" do
    context "using default list" do
      it "should update to-do description" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.update(task: target_task, update: update_task)
        expect(find_task(list: default_list, regex: /#{update_task}/o)).to_not be_nil
      end
    end

    context "using target list" do
      it "should update to-do description" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.update(task: target_task, update: update_task, list: target_list)
        expect(find_task(list: target_list, regex: /#{update_task}/o)).to_not be_nil
      end
    end
  end

  describe "#done" do
    context "using default list" do
      it "should prefix completed to-do with '[DONE]" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.done(task: target_task, list: default_list)
        expect(find_task(task: target_task, list: default_list, regex: /DONE/)).to be_true
      end
    end

    context "using target list" do
      it "should prefix completed to-do with '[DONE]" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.done(task: target_task, list: target_list)
        expect(find_task(task: target_task, list: target_list, regex: /DONE/)).to be_true
      end
    end
  end

  describe "#delete" do
    context "using default list" do
      it "should delete old to-do" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.delete(task: target_task, list: default_list)
        expect(File.new(default_list,'r').readlines).to_not include(target_task)
      end

      it "should delete all old to-dos" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.delete_all(task: target_task, list: default_list)
        expect(File.new(default_list,'r').readlines).to have(0).things
      end
    end

    context "using target list" do
      it "should delete old to-do" do
        taskmaster.new(task: test_task, list: default_list)
        taskmaster.delete(task: target_task, list: target_list)
        expect(File.new(target_list,'r').readlines).to_not include(target_task)
      end

      it "should delete all old to-dos" do
        taskmaster.new(task: test_task, list: target_list)
        taskmaster.delete_all(task: target_task, list: target_list)
        expect(File.new(target_list,'r').readlines).to have(0).things
      end
    end
  end
end