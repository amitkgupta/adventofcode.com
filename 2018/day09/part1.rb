NUM_PLAYERS = 464
LAST_MARBLE_VALUE = 70918

scores = Array.new(NUM_PLAYERS, 0)
circle = [0]
current_index = 0

(1..LAST_MARBLE_VALUE).each do |v|
	if v % 23 != 0
		current_index = (current_index + 2) % circle.size
		circle.insert(current_index, v)
		next
	end

	scores[v % NUM_PLAYERS] += v
	current_index = (current_index - 7) % circle.size
	scores[v % NUM_PLAYERS] += circle.delete_at(current_index)
	current_index %= circle.size
end

puts scores.max
