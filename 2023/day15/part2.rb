inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

boxes = Array.new(256) {[]}

def hsh(str)
	curr = 0
	str.each_byte do |b|
		curr = ((curr + b) * 17) % 256
	end
	curr
end

File.read(inp_file).split(?,).each do |str|
	label, focal_length = str.split(/=|-/)
	box_idx = hsh(label)
	if focal_length.nil?
		boxes[box_idx].delete_if { |l| l.first == label }
	else
		box = boxes[box_idx]
		lens_idx = box.find_index { |l| l.first == label }
		if lens_idx.nil?
			box << [label, focal_length.to_i]
		else
			box[lens_idx][1] = focal_length.to_i
		end
	end
end

focusing_power = 0
boxes.each_with_index do |box, i|
	box.each_with_index do |l, j|
		focusing_power += (i+1) * (j+1) * (l.last)
	end
end

puts focusing_power