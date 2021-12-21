inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
firewall = File.read(inp_file).split("\n").map { |l| l.split(": ").map(&:to_i) }.to_h

severity = 0
(firewall.keys.max+1).times do |lvl|
	d = firewall[lvl]
	next if d.nil?
	scan_pos = lvl % 2*(d-1) < (d-1) ? lvl % (d-1) : (d-1) - (lvl % (d-1))
	severity += lvl * d if scan_pos.zero?
end
puts severity
