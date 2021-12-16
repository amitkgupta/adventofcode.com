triangles = Hash.new { |h,k| h[k] = [] }
File.read("input.txt").split("\n").each_with_index do |line, i|
	line.split.map(&:to_i).each_with_index { |n, j| triangles[[i/3, j]] << n }
end
puts triangles.values.count { |t| t[0] + t[1] > t[2] && t[0] + t[2] > t[1] && t[1] + t[2] > t[0] }
