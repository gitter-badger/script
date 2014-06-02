module Sandwhich
  class PeanutButterJelly
    attr_accessor :sandwhich_count

    def initialize(sandwhich_count)
      self.sandwhich_count = sandwhich_count
    end

    def count
      self.sandwhich_count
    end
  end

  class HamCheese
    attr_accessor :sandwhich_count

    def initialize
      self.sandwhich_count = 1
    end

    def count
      self.sandwhich_count
    end
  end
end

include Sandwhich

describe PeanutButterJelly do
  describe "#initialize" do
    it "should initialize with sandwich count" do
      sandwiches = PeanutButterJelly.new(3)
      expect(sandwiches.count).to equal(3)
    end
  end
end

describe HamCheese do
  describe "#initialize" do
    it "should initialize and automatically set 1 count" do
      sandwiche = HamCheese.new
      expect(sandwiche.count).to equal(1)
    end
  end
end
