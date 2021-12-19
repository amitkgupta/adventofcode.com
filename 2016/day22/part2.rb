nodes = File.read("input.txt").split("\n")[2..-1].map do |l|
	_, _, used, avail, _ = l.split
	[used[0...-1].to_i, avail[0...-1].to_i]
end

nodes.each_with_index do |n,i|
	if i == 0
		print("(")
	elsif i == 25
		puts(" G")
		next
	else
		print(" ")
	end

	if n.first > 100
		print("#")
	elsif n.first > 0
		print(".")
	else
		print("_")
	end

	if i == 0
		print(")")
	elsif i % 26 == 25
		puts("")
	else
		print(" ")
	end
end
