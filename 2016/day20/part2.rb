N, inp_file = ENV["TEST"] == "true" ? [9, "test.txt"] : [4294967295, "input.txt"]
count = 0
max = File.read(inp_file).split.map { |l| l.split(?-).map(&:to_i) }.sort_by!(&:first).inject(0) do |mx, rng|
	count += (rng.first - mx) - 1 if rng.first > mx
	rng.last > mx ? rng.last : mx
end
count += N-max
puts count
