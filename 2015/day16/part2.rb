sues = {}
File.read("input.txt").split("\n").each do |l|
	sue, attrs = l.split(": ", 2)
	num = sue.match(/\d+/)[0]
	sues[num] = attrs.split(", ").map { |attr| attr.split(": ") }.to_h
end

sues.each do |sue, attrs|
	correct = attrs.all? do |k,v|
		case k
		when "children"
			v == "3"
		when "cats"
			v.to_i > 7
		when "samoyeds"
			v == "2"
		when "pomeranians"
			v.to_i < 3
		when "akitas"
			v == "0"
		when "vizslas"
			v == "0"
		when "goldfish"
			v.to_i < 5
		when "trees"
			v.to_i > 3
		when "cars"
			v == "2"
		when "perfumes"
			v == "1"
		end
	end
	if correct
		puts sue
		break
	end
end
