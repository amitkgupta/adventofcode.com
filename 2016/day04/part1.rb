ans = File.read("input.txt").split("\n").inject(0) do |sum, line|
	chars, sector_id, actual_checksum = line.match(/([a-z\-]{5,})\-(\d+)\[([a-z]{5})\]/)[1..3]
	expected_checksum = chars.gsub("-", "").chars.uniq.sort do |a, b|
		x = chars.count(b) <=> chars.count(a)
		x == 0 ? a <=> b : x
	end[0, 5].join
	expected_checksum == actual_checksum ? sum + sector_id.to_i : sum
end
puts ans
