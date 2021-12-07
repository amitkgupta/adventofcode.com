inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

crabs = File.read(inp_file).split(",").map(&:to_i)

best = Float::INFINITY
(crabs.min .. crabs.max).to_a.each do |p|
    sum = crabs.inject(0) { |sum, c| sum + (c-p).abs }
    best = sum if sum < best
end
puts best
