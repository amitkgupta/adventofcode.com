require "set"

inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"

tls = File.read(inp_file).split("\n").select do |line|
	hn_seqs, sn_seqs, seq = [], [], ""
	line.chars.each do |c|
		case c
		when ?[
			sn_seqs << seq
			seq = ""
		when ?]
			hn_seqs << seq
			seq = ""
		else
			seq += c
		end
	end
	sn_seqs << seq
	
	babs = Set.new
	sn_seqs.each do |s|
		(s.size-2).times { |i| babs.add(s[i+1] + s[i] + s[i+1]) if s[i] != s[i+1] && s[i] == s[i+2] }
	end
	babs.any? { |bab| hn_seqs.any? { |s| s.include?(bab) } }
end

puts ENV["TEST"] == "true" ? tls : tls.size
