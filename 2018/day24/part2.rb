def damage(attacker, attackee)
	return 0 if attackee.immunities.include?(attacker.attack_type)
	return 2 * attacker.effective_power if attackee.weaknesses.include?(attacker.attack_type)
	attacker.effective_power
end

class Group
	attr_reader :num_units, :hit_points, :weaknesses, :immunities, :attack_damage, :attack_type, :initiative, :affiliation

	def initialize(num_units, hit_points, weaknesses, immunities, attack_damage, attack_type, initiative, affiliation)
		@num_units = num_units
		@hit_points = hit_points
		@weaknesses = weaknesses
		@immunities = immunities
		@attack_damage = attack_damage
		@attack_type = attack_type
		@initiative = initiative
		@affiliation = affiliation
		@boost = 0
	end

	def dead?
		@num_units.zero?
	end

	def effective_power
		@num_units * (@attack_damage + @boost)
	end

	def take_damage(damage)
		@num_units -= [damage/@hit_points, @num_units].min
	end

	def set_boost(boost)
		@boost = boost
	end

	include Comparable
	def <=>(other_group)
		[other_group.effective_power, other_group.initiative] <=> [effective_power, initiative]
	end
end

initial_groups = []

affiliation = "immune_system"
File.read("input.txt").split("\n").each do |l|
	if l == "Infection:"
		affiliation = "infection"
		next
	end

	next unless l.include?("units")

	num_units, hit_points, attack_damage, initiative = /(\d+)\D*(\d+)\D*(\d+)\D*(\d+)/.match(l)[1, 4].map(&:to_i)
	attack_type = /(\w+) damage at/.match(l)[1]
	weaknesses = l.include?("weak") ? /weak to ([^);]*)/.match(l)[1].split(",").map(&:strip) : []
	immunities = l.include?("immune") ? /immune to ([^);]*)/.match(l)[1].split(",").map(&:strip) : []

	initial_groups << Group.new(num_units, hit_points, weaknesses, immunities, attack_damage, attack_type, initiative, affiliation)
end

min_boost = 0
max_infection_num_units = initial_groups.select { |g| g.affiliation == "infection" }.map(&:num_units).max
max_infection_hit_points = initial_groups.select { |g| g.affiliation == "infection" }.map(&:hit_points).max
min_immune_system_num_units = initial_groups.select { |g| g.affiliation == "immune_system" }.map(&:num_units).min
min_immune_system_attack_damage = initial_groups.select { |g| g.affiliation == "immune_system" }.map(&:attack_damage).min
max_boost = (max_infection_num_units * max_infection_hit_points)/min_immune_system_num_units - min_immune_system_attack_damage

answer = nil

until min_boost + 1 == max_boost do
	boost = (min_boost + max_boost)/2
	groups = initial_groups.map(&:dup)
	groups.select { |g| g.affiliation == "immune_system" }.each { |g| g.set_boost(boost) }

	until groups.map(&:affiliation).uniq.size == 1 do
		total_units = groups.map(&:num_units).inject(:+)

		groups.sort!

		selected_targets = []
		attack_map = {}
		
		groups.each do |group|
			target = nil
			max_damage = 0

			(groups - selected_targets).each do |potential_target|
				if potential_target.affiliation != group.affiliation
					hypothetical_damage = damage(group, potential_target)
					if hypothetical_damage > max_damage
						target = potential_target
						max_damage = hypothetical_damage
					end
				end
			end

			unless target.nil?
				attack_map[group] = target
				selected_targets << target
			end
		end

		groups.sort_by(&:initiative).reverse.each do |group|
			next unless attack_map.has_key?(group) && !group.dead?

			target = attack_map[group]
			target.take_damage(damage(group, target))
		end

		groups.reject!(&:dead?)

		break if groups.map(&:num_units).inject(:+) == total_units
	end

	if groups.map(&:affiliation).uniq == ["immune_system"]
		max_boost = boost
		answer = groups.map(&:num_units).inject(:+)
	else
		min_boost = boost
	end
end

puts answer