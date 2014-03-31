#!/usr/bin/ruby -w
# tune_guitar.rb
# Description: Tune your guitar



## 1. record your first string
## 2. extract signal vs time data
## 3.


## 1. record your first string
# LINK http://audacity.sourceforge.net/
## 2. extract signal vs time data
# LINK http://sox.sourceforge.net/
# LINK http://www.gnuplot.info/
# sox guitar_first_string.wav guitar_first_string.dat
# NOTE guitar_first_string.dat will consist of several columns – time and volumes of every channel:
## 3. convert .wav file data (sound vs time) to its spectrum (magnitude vs frequency).
# LINK http://www.fftw.org/

##################
### plotter.rb ###

# require 'open3'

# class GNUPlotter < Struct.new(:data, :params)
#   def plot
#     image, s = Open3.capture2("gnuplot", stdin_data: gnuplot_commands, binmode: true)
#     system "open #{params[:image_name]}"
#   end

#   private
#   def gnuplot_commands
#     commands = %{
#       set terminal png font "/Library/Fonts/Arial.ttf" 14
#       set title "#{params[:title]}"
#       set xlabel "#{params[:x_axis_title]}"
#       set ylabel "#{params[:y_axis_title]}"
#       set output "#{params[:image_name]}"
#       set key off
#       plot "-" with points
#     }

#     data.each do |x, y|
#       commands << "#{x} #{y}\n"
#     end

#     commands << "e\n"
#   end
# end

# sound_data = File.read("guitar_first_string.dat").split("\n")[2..-1].map { |row| row.split.map(&:to_f) }.
#   map { |r| r.first(2) }

# plot_params = {
#   image_name: "plot.png",
#   title: "Guitar first string sound",
#   x_axis_title: "Time, s",
#   y_axis_title: ".wav signal"
# }

# plotter = GNUPlotter.new(sound_data, plot_params)
# plotter.plot

### plotter.rb ###
##################

####################
### transform.rb ###

# require "fftw3"
# require_relative "plotter"

# def read_channel_data(filename, channel_number)
#   data = File.read(filename).split("\n")[2..-1].map { |row| row.split.map(&:to_f) }
#   duration = data.last[0]
#   signal = data.map { |r| r[channel_number] }

#   return signal, duration
# end

# def calculate_fft(signal, duration, max_points = 3000)
#   na = NArray[signal]
#   fc = FFTW3.fft(na)

#   spectrum = fc.real.to_a.flatten.first(na.length / 2).first(max_points).each_with_index.map do |val, index|
#     [index / duration, val.abs]
#   end
# end

# signal, duration = read_channel_data("guitar_first_string.dat", 1)
# spectrum = calculate_fft(signal, duration)

# max_frequency = spectrum.sort_by(&:last).last.first.round(2)

# spectrum_plot_params = {
#   image_name: "spectrum.png",
#   title: "First guitar string spectrum #{max_frequency}Hz",
#   x_axis_title: "Frequency, Hz",
#   y_axis_title: "Magnitude"
# }

# plotter = GNUPlotter.new(spectrum, spectrum_plot_params)
# plotter.plot

### transform.rb ###
####################

