SERIAL_NUMBER = 9306

$power_levels = {}

def power_level(x,y,size)
	return $power_levels[[x,y,size]] if $power_levels.has_key?([x,y,size])

	if size == 1
		$power_levels[[x,y,size]] = ((((x+10)*y + SERIAL_NUMBER)*(x+10) / 100) % 10) - 5
	elsif size % 2 == 0
		half_size = size/2
		$power_levels[[x,y,size]] = power_level(x,y,half_size) + \
									 power_level(x+half_size,y,half_size) + \
									 power_level(x,y+half_size,half_size) + \
									 power_level(x+half_size,y+half_size,half_size)
	else
		half_size = size/2
		$power_levels[[x,y,size]] = power_level(x,y,half_size+1) + \
							 power_level(x+half_size+1,y,half_size) + \
							 power_level(x,y+half_size+1,half_size) + \
							 power_level(x+half_size,y+half_size,half_size+1) - \
							 power_level(x+half_size,y+half_size,1)
	end

	$power_levels[[x,y,size]]
end

top_x, top_y, best_size, max_total_power = nil, nil, nil, -Float::INFINITY
(1..300).each do |size|
	(1..(301-size)).each do |x|
		(1..(301-size)).each do |y|
			if power_level(x,y,size) > max_total_power
				max_total_power = power_level(x,y,size)
				top_x = x
				top_y = y
				best_size = size
			end
		end
	end
end

puts "#{top_x},#{top_y},#{best_size}"
