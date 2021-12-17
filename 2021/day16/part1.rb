inp_file = ENV["TEST"] == "true" ? "test1.txt" : "input.txt"

def version_sum(bin)
	return 0 if bin.size < 6

	version = bin[0, 3].to_i(2)
	
	if bin[3, 3] == "100"
		i = 6
		loop do
			return 0 if bin.size <= i
			break if bin[i] == ?0
			i += 5
		end
		i += 5
		return 0 if bin.size <= i
		return version + version_sum(bin[i .. -1])
	else
		return 0 if bin.size < 7
		start = 7 + (bin[6] == ?0 ? 15 : 11)
		return 0 if bin.size <= start
		return version + version_sum(bin[start .. -1])
	end
end

File.read(inp_file).split.each { |l| puts version_sum(l.to_i(16).to_s(2).rjust(4*l.size, ?0)) }
