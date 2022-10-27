#spec/caesar_cipher_spec.rb

require './lib/caesar_cipher'

describe CaesarCipher do
  describe "#encode" do
    it "encodes input str by replacing original letters with “shift” number of characters ahead in the alphabet." do
      cs = CaesarCipher.new
      expect(cs.encode("abcde", 5)).to eql("fghij")
    end
  end
end
