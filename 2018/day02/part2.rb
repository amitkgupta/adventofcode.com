ids = File.read("input.txt").split

(ids.size - 1).times do |i1|
	id1 = ids[i1]
	(i1+1 ... ids.size).each do |i2|
		id2 = ids[i2]
		id1.size.times do |j|
			if id1[0...j] == id2[0...j] && id1[j+1..-1] == id2[j+1..-1]
				puts id1[0...j] + id1[j+1..-1]
				exit
			end
		end
	end
end
