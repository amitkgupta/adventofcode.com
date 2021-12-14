instructions = File.read("input.txt").split("\n").map do |l|
	l.split(" -> ").reverse
end.to_h

def resolve(k, signals, instructions)
	if signals.has_key?(k)
		return
	end

	parts = instructions[k].split.map do |rp|
		if ["NOT", "AND", "OR", "LSHIFT", "RSHIFT"].include?(rp)
			rp
		elsif rp.to_i.to_s == rp
			rp.to_i
		else
			resolve(rp, signals, instructions)
			signals[rp]
		end
	end

	case parts[-2]
	when nil
		signals[k] = parts.first
	when "NOT"
		signals[k] = ~parts.last
		signals[k] += 65536 if signals[k] < 0
	when "OR"
		signals[k] = parts.first | parts.last
	when "AND"
		signals[k] = parts.first & parts.last
	when "LSHIFT"
		signals[k] = parts.first << parts.last
	when "RSHIFT"
		signals[k] = parts.first >> parts.last
	end
end

signals = {}
instructions.keys.each { |k| resolve(k, signals, instructions) }

instructions["b"] = signals["a"].to_s
signals = {}
instructions.keys.each { |k| resolve(k, signals, instructions) }

puts signals["a"]
