# Caesar's cipher

def caesar_cipher(str, num)
  lower = ("a".."z").to_a
  lower_to = lower.rotate(num.to_i)

  upper = ("A".."Z").to_a
  upper_to = upper.rotate(num.to_i)

  encoded_string = str.split('').map do |c|  
    if lower.include?(c) 
      lower_to[lower.index(c)]
    elsif upper.include?(c)
      upper_to[upper.index(c)]
    else
      c
    end
  end
  
  encoded_string.join('')
end


message = ""
puts "Enter message:"
message = gets.chomp

cipher = 0
puts "Enter a number:"
loop do
  cipher = gets.chomp
  break if cipher.to_i != 0
end

puts caesar_cipher(message, cipher)
