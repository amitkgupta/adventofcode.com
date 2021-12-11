inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

octopi = File.read(inp_file).split("\n").map { |l| l.chars.map(&:to_i) }
h, w = octopi.size, octopi.first.size

step = 0
loop do
	unprocessed_flashes = {}
	h.times do |i|
		w.times do |j|
			octopi[i][j] += 1
			unprocessed_flashes[[i, j]] = true if octopi[i][j] > 9
		end
	end

	processed_flashes = {}
	until unprocessed_flashes.empty?
		tmp = {}
		processed_flashes.merge!(unprocessed_flashes)
		unprocessed_flashes.keys.each do |f|
			([f.first-1, 0].max .. [f.first+1, h-1].min).to_a.each do |i|
				([f.last-1, 0].max .. [f.last+1, w-1].min).to_a.each do |j|
					octopi[i][j] += 1
					tmp[[i, j]] = true if octopi[i][j] > 9 && !processed_flashes.has_key?([i,j])
				end
			end
		end
		unprocessed_flashes = tmp
	end

	processed_flashes.keys.each { |f| octopi[f.first][f.last] = 0 }
	
	step += 1

	if processed_flashes.size == h * w
		puts step
		break
	end
end
