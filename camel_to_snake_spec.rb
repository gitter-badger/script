class CamelToSnake
  def to_snake(camel)
    camel_arr = camel.split(/(?=[A-Z])/)
    camel_arr.join("_").downcase!
  end
end

describe CamelToSnake do
  describe "#to_snake" do
    let(:camel) { "HotDogBus" }

    it "should take argument 'HotDogBus' and return 'hot_dog_bus'" do
      converter = CamelToSnake.new
      snake = converter.to_snake(camel)
      expect(snake).to eq("hot_dog_bus")
    end
  end
end
