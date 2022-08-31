def caesar_cipher(string, shift)
  alphabet = ("a".."z").to_a
  encrypter = Hash[alphabet.zip(alphabet.rotate(shift))]
  string.chars.map do |c| 
    if c == c.downcase
      encrypter.fetch(c, " ")
    else
      encrypter.fetch(c.downcase, " ").upcase
    end
  end.join
end

# TESTS
# p caesar_cipher("test string", 4)
# p caesar_cipher("tESt StriNg", 4)
