blocked = ("A".."Z").to_a
available = []
finished = 0

instructions = File.read("input.txt").split("\n")

until finished == 26
	blocked.each do |step|
		unless instructions.any? { |instr| instr.include? (step + " can begin") }
			blocked.delete(step)
			available << step
		end
	end

	available.sort!
	step = available.shift
	print step

	finished += 1
	instructions.delete_if { |instr| instr.include? (step + " must be") }
end

puts
