def substrings(text, dictionary)
  result = Hash.new(0)
  downcase_text = text.downcase

  dictionary.each do |word|
    matches = downcase_text.scan(word).length
    result[word] = matches unless matches == 0
  end

  return result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

# Test Single word string.
substrings("below", dictionary)
# Test Multi-word string.
substrings("Howdy partner, sit down! How's it going?", dictionary)
