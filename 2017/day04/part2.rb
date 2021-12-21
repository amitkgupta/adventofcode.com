puts (File.read("input.txt").split("\n").count do |line|
	phrase = line.split
	phrase.uniq.size == phrase.size && phrase.each_with_index.all? do |w1,i1|
		phrase.each_with_index.none? { |w2,i2| i1 != i2 && w1.chars.sort == w2.chars.sort }
	end
end)
