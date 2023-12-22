inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

def arrangements(row, groups)
	if groups.empty?
		return row.include?(?#) ? 0 : 1
	end

	return 0 if row.empty?

	ans = 0
	ans += arrangements(row[1 .. -1], groups) if row[0] != ?#
	ans += 1 if groups.size == 1 && row.size == groups[0] && !row.include?(?.)
	ans += arrangements(row.drop(groups[0]+1), groups.drop(1)) if row.size > groups[0] && !row.first(groups[0]).include?(?.) && row[groups[0]] != ?#
	ans
end

sum = 0
File.read(inp_file).split("\n").each do |l|
	raw_row, raw_groups = l.split
	row = raw_row.chars
	groups = raw_groups.split(",").map(&:to_i)
	sum += arrangements(row, groups)
end 

puts sum