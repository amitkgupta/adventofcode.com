require "matrix"

R, L = Matrix.columns([[0, -1], [1, 0]]), Matrix.columns([[0, 1], [-1, 0]])
pos, dir = Matrix.column_vector([0,0]), Matrix.column_vector([0,1])
File.read("input.txt").split(", ").each do |line|
	rot, dist = line[0], line[1..-1].to_i
	dir = rot == ?R ? (R * dir) : (L * dir)
	pos += dist * dir
end
puts pos.map(&:abs).sum
