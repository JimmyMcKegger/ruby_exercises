# Takes a string and an array of substrings. Return a hash listing how many times the (case insensitive) substrings were found within the main string.

def substrings(phrase, arr)
  h = Hash.new(0)
  words = phrase.downcase.split
  
  arr.each do |sub|
    words.each do |w|
      if w.include?(sub.downcase)
        h[sub] += 1
      end
    end
  end
  
  h
end
