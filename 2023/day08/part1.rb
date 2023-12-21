inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

instructions, raw_network = File.read(inp_file).split("\n\n")
network = {}
raw_network.split("\n").each { |l| n, l, r = l.scan(/\w\w\w/); network[n] = [l, r] }

curr = "AAA"
count = 0
loop do
	break if curr == "ZZZ"

	if instructions[count % instructions.size] == ?L
		curr = network[curr][0]
	else
		curr = network[curr][1]
	end
	count += 1
end

puts count
