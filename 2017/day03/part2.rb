input = 347991

def neighbour_sum(grid, i, j)
	grid[[i-1,j-1]] + grid[[i-1,j]] + grid[[i-1,j+1]] +
	grid[[i,j-1]]  + grid[[i,j+1]] +
	grid[[i+1,j-1]] + grid[[i+1,j]] + grid[[i+1,j+1]]
end

grid = Hash.new { |h,k| h[k] = 0 }
grid[[0,0]] = 1

r = 1
loop do
	(1-r..r).each do |j|
		grid[[r,j]] = neighbour_sum(grid, r, j)
		if grid[[r,j]] > input
			puts grid[[r,j]]
			exit
		end
	end

	(-r..r-1).to_a.reverse.each do |i|
		grid[[i,r]] = neighbour_sum(grid, i, r)
		if grid[[i,r]] > input
			puts grid[[i,r]]
			exit
		end
	end

	(-r..r-1).to_a.reverse.each do |j|
		grid[[-r,j]] = neighbour_sum(grid, -r, j)
		if grid[[-r,j]] > input
			puts grid[[-r,j]]
			exit
		end
	end

	(1-r..r).each do |i|
		grid[[i,-r]] = neighbour_sum(grid, i, -r)
		if grid[[i,-r]] > input
			puts grid[[i,-r]]
			exit
		end
	end

	r += 1
end
