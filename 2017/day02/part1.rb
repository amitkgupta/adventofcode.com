puts (File.read("input.txt").split("\n").inject(0) do |checksum, line|
	ns = line.split.map(&:to_i)
	checksum + ns.max - ns.min
end)
