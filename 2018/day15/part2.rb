class Unit
	attr_reader :type, :row, :col, :hp, :id

	def initialize(type, row, col, damage, id)
		@type, @row, @col, @hp, @damage, @id = type, row, col, 200, (type == ?E ? 3 : damage), id
	end

	def take_hit
		@hp -= @damage
	end

	def dead?
		@hp <= 0
	end

	def adjacent?(other_unit)
		[0,1] == [(@row - other_unit.row).abs, (@col - other_unit.col).abs].sort
	end

	def move_to(pos)
		@row, @col = pos[0], pos[1]
	end

	def is_elf?
		@type == ?E
	end

	include Comparable

	def <=>(other_unit)
		[@row, @col] <=> [other_unit.row, other_unit.col]
	end
end

class Map
	def initialize(path, damage)
		@grid = File.read(path).split("\n").map(&:chars)
		@units = []
		@grid.each_index do |i|
			@grid[i].each_index do |j|
				char = @grid[i][j]
				if [?E, ?G].include?(char)
					@grid[i][j] = ?.
					@units << Unit.new(char, i, j, damage, @units.size) 
				end
			end
		end
	end

	def tick
		@units.sort!

		i = 0
		while i < @units.size do
			@current_unit = @units[i]

			return true unless any_current_targets?

			move_current unless any_in_current_range?

			if any_in_current_range?
				attackee = current_attackee
				attackee.take_hit
				if attackee.dead?
					attackee_index = @units.index(attackee)
					@units.delete(attackee)
					return true if attackee.is_elf?
					i += 1 if attackee_index > i
				else
					i += 1
				end
			else
				i += 1
			end
		end

		return false
	end

	def total_hp
		@units.map(&:hp).sum
	end

	def elves_won?
		@units.all? { |u| u.is_elf? }
	end

	def display
		@grid.each_index do |i|
			@grid[i].each_index do |j|
				unit = @units.find { |u| [u.row, u.col] == [i, j] }
				print(unit.nil? ? @grid[i][j] : unit.id.to_s(32))
			end
			puts
		end
		@units.sort_by(&:id).each do |u|
			puts '%s #%s %03dHP (%02d,%02d)' % [u.type, u.id.to_s(32), u.hp, u.row, u.col]
		end
	end
	
	private

	def any_current_targets?
		@current_targets = @units.select { |u| @current_unit.type != u.type }
		@current_targets.any?
	end

	def any_in_current_range?
		@current_in_range = @current_targets.select { |u| @current_unit.adjacent?(u) }
		@current_in_range.any?
	end

	def current_attackee		
		weakest_hp = @current_in_range.map(&:hp).min
		@current_in_range.select { |u| u.hp == weakest_hp }.sort.first
	end

	def move_current
		candidate_steps = [].tap do |a|
			a << [@current_unit.row+1, @current_unit.col] if open?(@current_unit.row+1, @current_unit.col)
			a << [@current_unit.row-1, @current_unit.col] if open?(@current_unit.row-1, @current_unit.col)
			a << [@current_unit.row, @current_unit.col+1] if open?(@current_unit.row, @current_unit.col+1)
			a << [@current_unit.row, @current_unit.col-1] if open?(@current_unit.row, @current_unit.col-1)
		end
		return if candidate_steps.empty?

		targets_ranges = @current_targets.flat_map do |u|
			[].tap do |a|
				a << [u.row+1, u.col] if open?(u.row+1, u.col)
				a << [u.row-1, u.col] if open?(u.row-1, u.col)
				a << [u.row, u.col+1] if open?(u.row, u.col+1)
				a << [u.row, u.col-1] if open?(u.row, u.col-1)
			end
		end.uniq
		
		distances_from_current = distances_from([@current_unit.row, @current_unit.col])
		reachables = targets_ranges.reject { |r| distances_from_current[r].infinite? }
		return if reachables.empty?

		min_reachable_dist = reachables.map { |r| distances_from_current[r] }.min
		chosen = reachables.select { |r| distances_from_current[r] == min_reachable_dist }.sort.first

		candidate_distances_to_chosen = candidate_steps.
			map { |candidate| [candidate, distances_from(candidate)[chosen]] }.
			to_h
		min_candidate_distance_to_chosen = candidate_distances_to_chosen.values.min
		@current_unit.move_to(candidate_steps.
			select { |candidate| candidate_distances_to_chosen[candidate] == min_candidate_distance_to_chosen }.
			sort.
			first
		)
	end

	def open?(row, col)
		@grid[row][col] != ?# && @units.all? { |u| u.row != row || u.col != col }
	end

	def distances_from(start)
		dist = {start => 0}
		unvisited = [start]

		@grid.each_index do |row|
			@grid[row].each_index do |col|
				next unless open?(row, col)
				next if [row, col] == start
				dist[[row, col]] = Float::INFINITY
				unvisited << [row, col]
			end
		end

		until unvisited.empty?
			min_unvisited_dist = unvisited.map { |p| dist[p] }.min
			break if min_unvisited_dist.infinite?

			visitee = unvisited.find { |p| dist[p] == min_unvisited_dist }
			unvisited.delete(visitee)

			unvisited.select { |p| (p[0] - visitee[0]).abs + (p[1] - visitee[1]).abs == 1 }.each do |p|
				candidate_dist = dist[visitee] + 1
				dist[p] = candidate_dist if candidate_dist < dist[p]
			end
		end

		return dist
	end
end

upper_bound = 17
lower_bound = 14
outcomes = {}
until lower_bound + 1 == upper_bound do
	damage = (lower_bound+upper_bound)/2
	map = Map.new("52374.txt", damage)

	num_rounds = 0
	until map.tick do
		num_rounds += 1
	end

	if map.elves_won?
		upper_bound = damage
		outcomes[damage] = num_rounds * map.total_hp
	else
		lower_bound = damage
	end
end

puts outcomes[upper_bound]