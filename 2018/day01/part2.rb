freq = 0
freqs = { 0 => true }
loop do
	File.read("input.txt").split.each do |line|
		freq += line.to_i
		if freqs.has_key?(freq)
			puts freq
			exit
		end
		freqs[freq] = true
	end
end
