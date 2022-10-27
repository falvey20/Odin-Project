#lib/caesar_cipher.rb


class CaesarCipher
  def encode(string, shift)
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
end

