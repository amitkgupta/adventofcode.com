buffer_size = 1
curr_pos = 0
zero_pos = 0
val_after_0 = 0
(1..50_000_000).each do |v|
	curr_pos = (curr_pos + 303) % buffer_size
	if curr_pos == zero_pos
		val_after_0 = v
	elsif curr_pos < zero_pos
		zero_pos += 1
	end
	buffer_size += 1
	curr_pos = (curr_pos + 1) % buffer_size
end
puts val_after_0
