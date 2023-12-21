inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"

instructions, raw_network = File.read(inp_file).split("\n\n")
network = {}
raw_network.split("\n").each { |l| n, l, r = l.scan(/\w\w\w/); network[n] = [l, r] }

ans = 1
network.keys.select { |k| k[-1] == ?A }.each do |curr|
	count = 0

	loop do
		break if curr[-1] == ?Z

		if instructions[count % instructions.size] == ?L
			curr = network[curr][0]
		else
			curr = network[curr][1]
		end
		count += 1
	end

	ans = ans.lcm(count)
end

puts ans