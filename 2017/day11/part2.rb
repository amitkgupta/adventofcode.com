cts = { "n" => 0, "ne" => 0, "se" => 0, "s" => 0, "sw" => 0, "nw" => 0 }

max = 0
File.read("input.txt").strip.split(?,).each do |d|
	cts[d] += 1

	x = [cts["n"], cts["s"]].min
	cts["n"] -= x
	cts["s"] -= x

	x = [cts["ne"], cts["sw"]].min
	cts["ne"] -= x
	cts["sw"] -= x

	x = [cts["nw"], cts["se"]].min
	cts["nw"] -= x
	cts["se"] -= x

	x = [cts["ne"], cts["nw"]].min
	cts["ne"] -= x
	cts["nw"] -= x
	cts["n"] += x

	x = [cts["se"], cts["sw"]].min
	cts["se"] -= x
	cts["sw"] -= x
	cts["s"] += x

	x = [cts["n"], cts["s"]].min
	cts["n"] -= x
	cts["s"] -= x

	x = [cts["n"], cts["se"]].min
	cts["n"] -= x
	cts["se"] -= x
	cts["ne"] += x

	x = [cts["n"], cts["sw"]].min
	cts["n"] -= x
	cts["sw"] -= x
	cts["nw"] += x

	x = [cts["s"], cts["ne"]].min
	cts["s"] -= x
	cts["ne"] -= x
	cts["se"] += x

	x = [cts["s"], cts["nw"]].min
	cts["s"] -= x
	cts["nw"] -= x
	cts["sw"] += x

	max = cts.values.sum if cts.values.sum > max
end

puts max
