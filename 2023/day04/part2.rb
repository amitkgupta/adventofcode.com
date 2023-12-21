inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

scores = []
lines = File.read(inp_file).split("\n")
lines.each do |l|
	w, y = l.split(?:).last.split(?|)
	winning = w.split.map(&:to_i)
	yours = y.split.map(&:to_i)
	scores << yours.count { |n| winning.include?(n) }
end

apps = Array.new(scores.size, 1)
scores.size.times do |i|
	(0 ... i).each do |j|
		apps[i] += apps[j] if scores[j] + j >= i
	end
end
puts apps.sum