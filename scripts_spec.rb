#!/usr/bin/ruby -w
# scripts.rb
# Author: Andy Bettisworth
# Description: Print a list of available scripts from ~/.bash_aliases

class Scripts
  SCRIPTS_PATH = "#{ENV['HOME']}/.bash_aliases"
  SCRIPT_REGEXP = /alias (?<script_alias>.*?)=/

  def list
    script_list = []
    File.open(SCRIPTS_PATH).each_line do |line|
      found_script = SCRIPT_REGEXP.match(line)

      if found_script
        script_list << found_script[:script_alias]
      end
    end
    script_list
  end
end

## USAGE
scripts = Scripts.new
scripts.list

# describe Scripts do
#   describe "#list" do
#     let(:bash_aliases_path) { "#{ENV['HOME']}/.bash_aliases" }
#     let(:script_regexp) { Regexp.new(/alias (?<script_alias>.*?)=/) }
#     let(:script_list) do
#       script_array = []
#       File.open(bash_aliases_path).each_line do |line|
#         found_script = script_regexp.match(line)

#         if found_script
#           script_array << found_script[:script_alias]
#         end
#       end
#       script_array
#     end

#     it "should print a list of available scripts from ~/.bash_aliases" do
#       scripts = Scripts.new
#       expect(scripts.list).to eq(script_list)
#     end
#   end
# end
