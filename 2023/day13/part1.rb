inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

ans = 0
File.read(inp_file).split("\n\n").each do |pat|
	rows = pat.split("\n")
	columns = Array.new(rows.first.size) { [] }
	rows.each { |row| row.chars.each_with_index { |c,i| columns[i] << c } }

	(1 .. rows.size-1).each do |n|
		mirror = true
		k = 1
		loop do
			break if n-k < 0 || (n+k-1) >= rows.size

			if rows[n-k] != rows[n+k-1]
				mirror = false
				break
			end

			k += 1
		end

		if mirror
			ans += 100*n
			break
		end
	end

	(1 .. columns.size-1).each do |n|
		mirror = true
		k = 1
		loop do
			break if n-k < 0 || (n+k-1) >= columns.size

			if columns[n-k] != columns[n+k-1]
				mirror = false
				break
			end

			k += 1
		end

		if mirror
			ans += n
			break
		end
	end
end

puts ans