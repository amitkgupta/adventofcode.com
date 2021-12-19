def josephus_2(n)
	2 * (n - (1 << (n.bit_length-1))) + 1
end

puts josephus_2(ENV["TEST"] == "true" ? 5 : 3004953)
