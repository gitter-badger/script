#!/usr/bin/ruby -w
# librarything_wordparser_spec.rb
# Description: Parse out count of words with 'n' letters

class WordParser
  def parse(input)
    input.match(/(\d*)\Wwords/)[1].to_i
  end
end

describe "WordParser" do
  it "should return number of words with 'X' letters" do
    parser = WordParser.new
    input1 = "10 words with 1 letter"
    input2 = "20 words with 2 letters"
    input3 = "7 words with 3 letters"
    input4 = "15 words with 4 letters, etc"
    output1 = parser.parse(input1)
    output2 = parser.parse(input2)
    output3 = parser.parse(input3)
    output4 = parser.parse(input4)
    output1.should eq(10)
    output2.should eq(20)
    output3.should eq(7)
    output4.should eq(15)
  end
end
