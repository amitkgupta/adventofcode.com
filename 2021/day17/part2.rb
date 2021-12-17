inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

tx = File.read(inp_file).split(",").first.split("=").last.split("..").map(&:to_i)
min_tx = tx.min
max_tx = tx.max

max_vx = max_tx
min_vx = ((Math.sqrt(1 + 8*min_tx) - 1)/2).ceil

ty = File.read(inp_file).split.last.split("=").last.split("..").map(&:to_i)
min_ty = ty.min
max_ty = ty.max

min_vy = min_ty
max_vy = -min_vy - 1

count = 0
(min_vx .. max_vx).each do |vx|
	(min_vy .. max_vy).each do |vy|
		x, y, i, _vx, _vy = 0, 0, 0, vx, vy
		while x <= max_tx && y >= min_ty
			x += _vx
			y += _vy
			if min_tx <= x && x <= max_tx && min_ty <= y && y <= max_ty
				count += 1
				break
			end
			i += 0
			_vx -= 1 unless _vx.zero?
			_vy -= 1
		end
	end
end

puts count
