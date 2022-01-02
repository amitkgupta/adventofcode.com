inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

components = []
lookup = Hash.new { |h,k| h[k] = [] }
File.read(inp_file).split.each_with_index do |line,i|
	comp = line.split(?/).map(&:to_i)
	components << comp
	lookup[comp.first] << i
	lookup[comp.last] << i
end

bridges = lookup[0].map { |i| { seq: [i], open: components[i].max, strength: components[i].max } }
max = bridges.map { |bridge| bridge[:strength] }.max
until bridges.empty?
	tmp_bridges = []
	bridges.each do |bridge|
		lookup[bridge[:open]].each do |i|
			next if bridge[:seq].include?(i)
			b = {
				seq: bridge[:seq] + [i],
				open: components[i][1 - components[i].index(bridge[:open])],
				strength: bridge[:strength] + components[i].sum,
			}
			tmp_bridges << b
			max = b[:strength] if b[:strength] > max
		end
	end
	bridges = tmp_bridges
end

puts max
