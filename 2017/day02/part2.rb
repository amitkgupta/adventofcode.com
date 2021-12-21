checksum = File.read("input.txt").split("\n").inject(0) do |cs, line|
	ns = line.split.map(&:to_i)
	val = nil
	catch :done do
		ns.each_with_index do |a, i|
			ns.each_with_index do |b, j|
				next if i == j
				if a % b == 0
					val = a/b
					throw :done
				end
			end
		end
	end
	cs + val
end
puts checksum
