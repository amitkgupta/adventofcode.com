puts File.read("input.txt").split("\n").inject(0) { |sum, str| sum + (str.to_i/3 - 2) }
