robots = Hash.new { |h, k| h[k] = { chips: [] } }
ready_bots = []
File.read("input.txt").split("\n").each do |line|
	if line[0, 3] == "bot"
		_, bot, _, _, _, lboo, low, _, _, _, hboo, high = line.split
		robots[bot][:instructions] = [
			lboo == "bot" ? low : nil,
			hboo == "bot" ? high : nil,
		]
	else
		_, val, _, _, _, bot = line.split
		robots[bot][:chips] << val.to_i
		ready_bots << bot if robots[bot][:chips].size == 2
	end
end

loop do
	bot = ready_bots.pop
	if robots[bot][:chips].sort == [17, 61]
		puts bot
		break
	end

	lb = robots[bot][:instructions].first
	unless lb.nil?
		robots[lb][:chips] << robots[bot][:chips].min
		ready_bots << lb if robots[lb][:chips].size == 2
	end

	hb = robots[bot][:instructions].last
	unless hb.nil?
		robots[hb][:chips] << robots[bot][:chips].max
		ready_bots << hb if robots[hb][:chips].size == 2
	end

	robots[bot][:chips] = []
end
