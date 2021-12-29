cubes = {}

inp_file = ENV["TEST"] == "true" ? "test1.txt" : "input.txt"
File.read(inp_file).split("\n").each do |line|
	state, raw_cuboid = line.split
	cuboid = raw_cuboid.split(?,).flat_map { |s| s.split(?=).last.split("..").map(&:to_i) }
	next if cuboid.any? { |n| n.abs > 50 }
	(cuboid[0] .. cuboid[1]).each do |x|
		(cuboid[2] .. cuboid[3]).each do |y|
			(cuboid[4] .. cuboid[5]).each do |z|
				case state
				when "on"
					cubes[[x,y,z]] = true
				when "off"
					cubes.delete([x,y,z])
				else
					puts "PANIC"
					exit
				end
			end
		end
	end
end

puts cubes.size
