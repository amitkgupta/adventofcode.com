puts (File.read("input.txt").split("\n").count do |line|
	phrase = line.split
	phrase.uniq.size == phrase.size
end)
