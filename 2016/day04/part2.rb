File.read("input.txt").split("\n").inject(0) do |sum, line|
	chars, sector_id, actual_checksum = line.match(/([a-z\-]{5,})\-(\d+)\[([a-z]{5})\]/)[1..3]
	expected_checksum = chars.gsub("-", "").chars.uniq.sort do |a, b|
		x = chars.count(b) <=> chars.count(a)
		x == 0 ? a <=> b : x
	end[0, 5].join
	next unless expected_checksum == actual_checksum
	chars.chars.each do |c|
		if c == ?-
			print " "
		else
			new_c = c.ord + (sector_id.to_i % 26)
			new_c -= 26 if new_c > ?z.ord
			print new_c.chr
		end
	end
	print ": "
	puts sector_id
end
