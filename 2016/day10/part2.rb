robots = Hash.new { |h, k| h[k] = { chips: [] } }
outputs = {}
ready_bots = []
File.read("input.txt").split("\n").each do |line|
	if line[0, 3] == "bot"
		_, bot, _, _, _, lboo, low, _, _, _, hboo, high = line.split
		if lboo == "bot"
			robots[bot][:low_bot] = low
		else
			robots[bot][:low_output] = low
		end
		if hboo == "bot"
			robots[bot][:high_bot] = high
		else
			robots[bot][:high_output] = high
		end
	else
		_, val, _, _, _, bot = line.split
		robots[bot][:chips] << val.to_i
		ready_bots << bot if robots[bot][:chips].size == 2
	end
end

loop do
	bot = ready_bots.pop
	break if bot.nil?

	if robots[bot].has_key?(:low_bot)
		lb = robots[bot][:low_bot]
		robots[lb][:chips] << robots[bot][:chips].min
		ready_bots << lb if robots[lb][:chips].size == 2
	end

	if robots[bot].has_key?(:high_bot)
		hb = robots[bot][:high_bot]
		robots[hb][:chips] << robots[bot][:chips].max
		ready_bots << hb if robots[hb][:chips].size == 2
	end

	if robots[bot].has_key?(:low_output)
		lo = robots[bot][:low_output]
		outputs[lo] = robots[bot][:chips].min
	end

	if robots[bot].has_key?(:high_output)
		ho = robots[bot][:high_output]
		outputs[ho] = robots[bot][:chips].max
	end

	robots[bot][:chips] = []
end

puts outputs[?0] * outputs[?1] * outputs[?2]
