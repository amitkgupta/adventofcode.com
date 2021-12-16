require "matrix"
require "set"

R, L = Matrix.columns([[0, -1], [1, 0]]), Matrix.columns([[0, 1], [-1, 0]])
pos, dir = Matrix.column_vector([0,0]), Matrix.column_vector([0,1])
visited = Set.new([pos])
catch :done do
	File.read("input.txt").split(", ").each do |line|
		dir = line[0] == ?R ? (R * dir) : (L * dir)
		line[1..-1].to_i.times do
			pos += dir
			throw :done if visited.include?(pos)
			visited.add(pos)
		end
	end
end
puts pos.map(&:abs).sum
