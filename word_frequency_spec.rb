class WordFrequency
  def get(content)
    content_array = content.downcase.split(/\b/).select { |x| /\w/.match(x) }
    content_hash = {}
    content_array.each { |word| content_hash.has_key?(word) ? content_hash[word] += 1 : content_hash[word] = 1 }
    content_hash
  end
end

describe WordFrequency do
  let (:content) { "This is. This is my content. The content is great." }

  describe "#get" do
    it "should return a hash of unique words" do
      freq = WordFrequency.new
      word_frequency = freq.get(content)
      expect(word_frequency).to be_a(Hash)
    end
  end
end
