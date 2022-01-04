class Worker
	def pick_up(step)
		return if step.nil?
		@step = step
		@time_left = step.ord - 4
	end

	def tick
		return nil unless busy?
		
		@time_left -= 1
		
		if @time_left == 0
			step = @step
			@step = nil
			@time_left = nil
			return step
		else
			return nil
		end
	end

	def busy?
		! @step.nil?
	end
end

workers = Array.new(5) { Worker.new }

blocked = ("A".."Z").to_a
available = []
finished = 0

instructions = File.read("input.txt").split("\n")

total_time = 0

until finished == 26
	blocked.each do |step|
		unless instructions.any? { |instr| instr.include? (step + " can begin") }
			blocked.delete(step)
			available << step
		end
	end

	workers.each { |worker| worker.pick_up(available.shift) unless worker.busy? }
	
	total_time += 1
	workers.map(&:tick).compact.each do |step|
		finished += 1
		instructions.delete_if { |instr| instr.include? (step + " must be") }
	end
end

puts total_time
