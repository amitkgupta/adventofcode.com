banks = ENV["TEST"] == "true" ? [0,2,7,0] : File.read("input.txt").strip.split.map(&:to_i)
seen = {}
cycles = 0
until seen.has_key?(banks)
	seen[banks] = cycles
	idx, max = 0, 0
	banks.each_with_index do |b, i|
		if b > max
			max = b
			idx = i
		end
	end
	banks[idx] = 0
	banks.size.times { |i| banks[i] += max/banks.size }
	(max % banks.size).times { |i| banks[(idx+i+1) % banks.size] += 1 }
	cycles += 1
end
puts cycles - seen[banks]
