ON, OFF, TOGGLE = "on", "off", "e"

lights = Hash.new(0)
File.read("input.txt").split("\n").each do |instr|
	action, p1, _, p2 = instr[5..-1].split
	x1, y1 = p1.split(",").map(&:to_i)
	x2, y2 = p2.split(",").map(&:to_i)
	(x1 .. x2).to_a.each do |x|
		(y1 .. y2).to_a.each do |y|
			case action
			when ON
				lights[[x,y]] += 1
			when OFF
				lights[[x,y]] -= 1 unless lights[[x,y]] == 0
			when TOGGLE
				lights[[x,y]] += 2
			end
		end
	end
end
puts lights.values.sum
