#!/usr/bin/env ruby -w
# window_spec.rb
# Author: Andy Bettisworth
# Description: Window manager command-line app
# Dependencies: libx11-dev, libglib2.0-dev, libxmu-dev

require 'wmctrl'

class RBWindow
  @window_manager
  @desktop
  @x_boundary
  @y_boundary
  @target_window

  ## Desktop boundary
  attr_reader :desktop
  attr_reader :x_boundary
  attr_reader :y_boundary

  ## Window data
  attr_reader :window_data
  attr_reader :window_id
  attr_reader :window_title
  attr_reader :window_class
  attr_reader :window_active
  attr_reader :window_desktop
  attr_reader :window_client_machine
  attr_reader :window_pid
  attr_reader :window_geometry
  attr_reader :window_state
  attr_reader :window_exterior_frame
  attr_reader :window_frame_extents
  attr_reader :window_strut

  def initialize
    @window_manager = WMCtrl.instance
    @desktop = @window_manager.list_desktops[0]
    @x_boundary = @desktop[:geometry][0]/2
    @y_boundary = @desktop[:geometry][1]/2
    @target_window = nil
    update_window_list
  end

  def create_application(application, application_argument = "")
    case application
    when "gnome-terminal"
      application_class = "gnome-terminal.Gnome-terminal"
    when "sublime"
      application_class = "sublime.Sublime"
    when "firefox"
      application_class = "Navigator.Firefox"
    end
    system "#{application} #{application_argument} &"
    @target_window = nil
    while @target_window.nil?
      update_window_list
      windows = @window_list.select {|window| window[:class] == application_class}
      @target_window = windows[0]
    end
  end

  def set_target_application(application)
    case application
    when "gnome-terminal"
      application_class = "gnome-terminal.Gnome-terminal"
    when "sublime"
      application_class = "sublime.Sublime"
    when "firefox"
      application_class = "Navigator.Firefox"
    end
    @target_window = nil
    while @target_window.nil?
      update_window_list
      windows = @window_list.select {|window| window[:class] == application_class}
      @target_window = windows[0]
    end
  end

  def read_window_data
    fail "Set target application." if @target_window.nil?

    @window_data = @window_manager.get_window_data(@target_window[:id])
    @window_id =  window_data[:id] # :id => 60817590,
    @window_title = window_data[:title] # :title => "Problem loading page - Mozilla Firefox",
    @window_class = window_data[:class] # :class => "Navigator.Firefox",
    @window_active = window_data[:active] # :active => nil,
    @window_desktop = window_data[:desktop] # :desktop => 0,
    @window_client_machine = window_data[:client_machine] # :client_machine => "base",
    @window_pid = window_data[:pid] # :pid => 2408,
    @window_geometry = window_data[:geometry] # :geometry => [1089, 624, 959, 576],
    @window_state = window_data[:state] # :state => ["_NET_WM_STATE_MAXIMIZED_VERT", "_NET_WM_STATE_MAXIMIZED_HORZ"],
    @window_exterior_frame = window_data[:exterior_frame] # :exterior_frame => [1089, 624, 959, 576],
    @window_frame_extents = window_data[:frame_extents] # :frame_extents => [0, 0, 0, 0],
    @window_strut = window_data[:strut] # :strut => nil
  end

  def relocate(target_workspace)
    fail "Set target workspace." if target_workspace.nil?
    fail "Set target application." if @target_window.nil?

    ## SET target workspace
    case target_workspace
    when "top-left"
      offset = [0,0]
    when "top-right"
      offset = [@x_boundary,0]
    when "bottom-left"
      offset = [0,@y_boundary]
    when "bottom-right"
      offset = [@x_boundary,@y_boundary]
    else
      fail "Unknown target workspace."
    end

    ## GET current workspace
    current_offset = desktop[:viewport]
    if current_offset == [0,0]
      current_workspace = 'top-left'
    elsif current_offset == [@x_boundary,0]
      current_workspace = 'top-right'
    elsif current_offset == [0,@y_boundary]
      current_workspace = 'bottom-left'
    elsif current_offset == [@x_boundary,@y_boundary]
      current_workspace = 'bottom-right'
    end

    ## SET relocate offsets
    case target_workspace
    when "top-left"
      case current_workspace
      when "top-left"
        offset = [0,0]
      when "top-right"
        offset = [@x_boundary,0]
      when "bottom-left"
        offset = [0,-@y_boundary]
      when "bottom-right"
        offset = [-@x_boundary,-@y_boundary]
      end
    when "top-right"
      case current_workspace
      when "top-left"
        offset = [-@x_boundary,0]
      when "top-right"
        offset = [0,0]
      when "bottom-left"
        offset = [@x_boundary,-@y_boundary]
      when "bottom-right"
        offset = [0,-@y_boundary]
      end
    when "bottom-left"
      case current_workspace
      when "top-left"
        offset = [0,@y_boundary]
      when "top-right"
        offset = [-@x_boundary,@y_boundary]
      when "bottom-left"
        offset = [0,0]
      when "bottom-right"
        offset = [-@x_boundary,0]
      end
    when "bottom-right"
      case current_workspace
      when "top-left"
        offset = [@x_boundary,@y_boundary]
      when "top-right"
        offset = [0,@y_boundary]
      when "bottom-left"
        offset = [@x_boundary,0]
      when "bottom-right"
        offset = [0,0]
      end
    else
      fail "Error getting current workspace."
    end

    ## SET offsets
    x_offset = offset[0]
    y_offset = offset[1]

    ## SET defaults
    gravity = 0
    x_dimension = 200
    y_dimension = 200

    ## UPDATE window position
    puts "Moving #{@target_window[:class]}"
    puts "from #{current_workspace} to #{target_workspace}"
    puts "by #{x_offset.to_s} x_offset and #{y_offset.to_s} y_offset."
    @window_manager.action_window(@target_window[:id], :move_resize,
      gravity,
      x_offset,
      y_offset,
      x_dimension,
      y_dimension)
  end

  def resize_window(gravity, x_offset, y_offset, x_dimension, y_dimension)
    fail "Set target application." if @target_window.nil?

    @window_manager.action_window(
      @target_window[:id],
      :move_resize,
      gravity,
      x_offset,
      y_offset,
      x_dimension,
      y_dimension)
  end

  def change_window_state(action, state)
    fail "Set target application." if @target_window.nil?

    @window_manager.action_window(
      @target_window[:id],
      :change_state,
      action,
      state)
  end

  def close_all_windows
    update_window_list
    @window_list.each do |window|
      @window_manager.action_window(window[:id], :close)
    end
  end

  def change_workspace(target_viewport)
    ## SET target viewport
    case target_viewport
    when "top-left"
      offset = [0,0]
    when "top-right"
      offset = [@x_boundary,0]
    when "bottom-left"
      offset = [0,@y_boundary]
    when "bottom-right"
      offset = [@x_boundary,@y_boundary]
    else
      fail "Unknown target viewport."
    end

    ## GET current viewport
    current_offset = desktop[:viewport]
    if current_offset == [0,0]
      current_viewport = 'top-left'
    elsif current_offset == [@x_boundary,0]
      current_viewport = 'top-right'
    elsif current_offset == [0,@y_boundary]
      current_viewport = 'bottom-left'
    elsif current_offset == [@x_boundary,@y_boundary]
      current_viewport = 'bottom-right'
    end

    ## SET offsets
    x_offset = offset[0]
    y_offset = offset[1]

    ## UPDATE window position
    puts "Moving viewport"
    puts "from #{current_viewport} to #{target_viewport}"
    puts "by #{x_offset.to_s} x_offset and #{y_offset.to_s} y_offset."
    @window_manager.change_viewport(x_offset, y_offset)
  end

private
  def update_window_list
    @window_list = @window_manager.list_windows.delete_if {|window| window[:class] == nil}
  end
end
