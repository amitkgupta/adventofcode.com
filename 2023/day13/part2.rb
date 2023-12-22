inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

ans = 0
File.read(inp_file).split("\n\n").each do |pat|
	rows = pat.split("\n")
	columns = Array.new(rows.first.size) { [] }
	rows.each { |row| row.chars.each_with_index { |c,i| columns[i] << c } }

	(1 .. rows.size-1).each do |n|
		num_diffs = 0
		k = 1
		loop do
			break if n-k < 0 || (n+k-1) >= rows.size

			rows.first.size.times do |i|
				if rows[n-k][i] != rows[n+k-1][i]
					num_diffs += 1
				end
			end

			break if num_diffs > 1

			k += 1
		end

		if num_diffs == 1
			ans += 100*n
			break
		end
	end

	(1 .. columns.size-1).each do |n|
		num_diffs = 0
		k = 1
		loop do
			break if n-k < 0 || (n+k-1) >= columns.size

			rows.size.times do |i|
				if columns[n-k][i] != columns[n+k-1][i]
					num_diffs += 1
				end
			end

			break if num_diffs > 1

			k += 1
		end

		if num_diffs == 1
			ans += n
			break
		end
	end
end

puts ans