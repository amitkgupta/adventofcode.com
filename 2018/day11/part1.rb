SERIAL_NUMBER = 9306

$power_levels = {}

def power_level(x,y)
	return $power_levels[[x,y]] if $power_levels.has_key?([x,y])
	$power_levels[[x,y]] = ((((x+10)*y + SERIAL_NUMBER)*(x+10) / 100) % 10) - 5
end

top_x, top_y, max_total_power = nil, nil, -Float::INFINITY
(1..298).each do |x|
	(1..298).each do |y|
		power_level = (0..2).map do |dx|
			(0..2).map { |dy| power_level(x+dx, y+dy) }.sum
		end.sum

		if power_level > max_total_power
			max_total_power = power_level
			top_x = x
			top_y = y
		end
	end
end

puts "#{top_x},#{top_y}"
