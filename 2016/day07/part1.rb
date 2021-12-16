def abba?(x)
	(x.size-3).times.any? { |i| x[i] == x[i+3] && x[i+1] == x[i+2] && x[i] != x[i+1] }
end

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

tls = File.read(inp_file).split("\n").select do |line|
	hn_seqs, non_hn_seqs, seq = [], [], ""
	line.chars.each do |c|
		case c
		when ?[
			non_hn_seqs << seq
			seq = ""
		when ?]
			hn_seqs << seq
			seq = ""
		else
			seq += c
		end
	end
	hn_seqs.none? { |s| abba?(s) } && non_hn_seqs.any? { |s| abba?(s) }
end

puts ENV["TEST"] == "true" ? tls : tls.size
