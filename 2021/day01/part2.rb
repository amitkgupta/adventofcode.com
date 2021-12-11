x = File.read("input.txt").split("\n").map(&:to_i)
puts (3...x.length).to_a.count { |i| x[i] > x[i-3] }
