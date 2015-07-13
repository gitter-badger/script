#!/usr/bin/ruby -w
# transpose_hash.rb
# Author: Andy Bettisworth
# Description: Transpose two hashes

require 'rspec'
require 'pry'

#     |  d1  |  d2  |  d3  |
#     ----------------------
# j1  |      |  e2  |  e3  |
# --------------------------
# j2  |  e4  |  e5  |  e6  |
# --------------------------
# j3  |  e7  |      |  e9  |
# --------------------------

def transpose(h)
  Hash[
    dates(h).map do |d|
      [
        d,
        Hash[ h.keys.map do |j|
          h[j][d] ? [j, h[j][d]] : nil
        end.compact ]
      ]
    end
  ]
end

def dates(h)
  h.values.map(&:keys).reduce(:|).sort
end

describe "transpose" do
  let(:starting) {
    {
      j1: { d2: :e2, d3: :e3 },
      j2: { d1: :e4, d2: :e5, d3: :e6 },
      j3: { d1: :e7, d3: :e9 }
    }
  }

  let(:transposed) {
    {
      d1: { j2: :e4, j3: :e7 },
      d2: { j1: :e2, j2: :e5 },
      d3: { j1: :e3, j2: :e6, j3: :e9 }
    }
  }

  it { expect(dates(starting)).to eq([:d1, :d2, :d3]) }
  it { expect(transpose(starting)).to eq(transposed) }
end