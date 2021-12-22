a, b = ENV["TEST"] == "true" ? [65, 8921] : [722, 354]

judge_a = []
judge_b = []
num_comparisons = 0
num_matches = 0
until num_comparisons == 5_000_000
	a = (a * 16807) % 2147483647
	b = (b * 48271) % 2147483647

	judge_a << a if a % 4 == 0
	judge_b << b if b % 8 == 0

	unless judge_a.empty? || judge_b.empty?
		num_comparisons += 1
		num_matches += 1 if (judge_a.shift % 65536) == (judge_b.shift % 65536)
	end
end

puts num_matches
