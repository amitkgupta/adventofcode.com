inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
File.read(inp_file).split.map { |l| l.split(?-).map(&:to_i) }.sort_by!(&:first).inject(0) do |max, rng|
	if rng.first > max + 1
		puts max + 1
		break
	end
	rng.last > max ? rng.last : max
end
