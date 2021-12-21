inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
firewall = File.read(inp_file).split("\n").map { |l| l.split(": ").map(&:to_i) }.to_h

(0..).each do |delay|
	x = firewall.none? do |lvl,d|
		t = lvl+delay
		(((t % (2*(d-1))) < (d-1)) ? (t % (d-1)) : ((d-1) - (t % (d-1)))).zero?
	end
	next unless x
	puts delay
	break
end
