def num_strategies(time_limit, distance_record)
	((time_limit + Math.sqrt(time_limit**2 - 4*distance_record))/2).ceil -
		((time_limit - Math.sqrt(time_limit**2 - 4*distance_record))/2).floor -
		1
end

puts num_strategies(48, 261) * 
	num_strategies(93, 1192) * 
	num_strategies(84, 1019) *
	num_strategies(66, 1063)