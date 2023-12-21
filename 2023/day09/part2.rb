inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

def predict(ns)
	return 0 if ns.all?(&:zero?)

	ns.first - predict((1 ... ns.size).to_a.map { |i| ns[i] - ns[i-1] })
end

ans = File.read(inp_file).split("\n").map do |l|
	predict(l.split.map(&:to_i))
end.inject(:+)

puts ans