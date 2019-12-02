def f(n)
    fuel = n/3 - 2
    fuel <= 0 ? 0 : fuel + f(fuel)
end

puts File.read("input.txt").split("\n").inject(0) { |sum, str| sum + f(str.to_i) }
