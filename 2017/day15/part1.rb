a, b = ENV["TEST"] == "true" ? [65, 8921] : [722, 354]

num_matches = 0
40_000_000.times do
	a = (a * 16807) % 2147483647
	b = (b * 48271) % 2147483647

	num_matches += 1 if a.to_s(2).rjust(32, ?0)[-16, 16] == b.to_s(2).rjust(32, ?0)[-16, 16]
end

puts num_matches
