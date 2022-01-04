fabrics = File.read("input.txt").split("\n").map do |line|
	[line.split.first[1..-1]] + \
		line.match(/@ (\d+),(\d+): (\d+)x(\d+)/).to_a[1..-1].map(&:to_i)
end

fabrics.each_with_index do |f1, i1|
	separate = true

	fabrics.each_with_index do |f2, i2|
		next if i1 == i2
		unless f1[1] >= f2[1]+f2[3] || f2[1] >= f1[1]+f1[3] || f1[2] >= f2[2]+f2[4] || f2[2] >= f1[2]+f1[4]
			separate = false
			break
		end
	end

	if separate
		puts f1.first
		exit
	end
end
