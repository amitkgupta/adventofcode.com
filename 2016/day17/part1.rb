require "digest"

passcodes = ENV["TEST"] == "true" ? %w{ihgpwlah kglvqrro ulqzkmiv} : %w{bwnlcvfs}

passcodes.each do |pc|
	path_map = { "" => [0,0] }

	until path_map.has_value?([3,3])
		tmp = {}
		path_map.each do |path, pos|
			up, down, left, right = Digest::MD5.hexdigest(pc + path)[0, 4].chars

			tmp[path + "U"] = [pos.first, pos.last-1] if pos.last != 0 && %w{b c d e f}.include?(up)
			tmp[path + "D"] = [pos.first, pos.last+1] if pos.last != 3 && %w{b c d e f}.include?(down)
			tmp[path + "L"] = [pos.first-1, pos.last] if pos.first != 0 && %w{b c d e f}.include?(left)
			tmp[path + "R"] = [pos.first+1, pos.last] if pos.first != 3 && %w{b c d e f}.include?(right)
		end
		path_map = tmp
	end

	puts path_map.key([3,3])
end
