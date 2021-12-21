digits = File.read("input.txt").strip.chars.map(&:to_i)
total = 0
digits.each_with_index { |d,i| total += d if d == digits[(i+1) % digits.size] }
puts total
