require "time"

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

events = File.read(inp_file).split("\n").sort_by! do |line|
	Time.parse(line[1,16])
end

sleep_minutes = Hash.new { |h,k| h[k] = Hash.new(0) }
curr_guard = nil
sleep_start = nil
events.each do |e|
	if e.include?("Guard")
		curr_guard = e.split[-3][1..-1]
		sleep_start = nil
	elsif
		e.include?("falls")
		sleep_start = e.split(?:).last.split(?]).first.to_i
	else
		(sleep_start...e.split(?:).last.split(?]).first.to_i).each do |m|
			sleep_minutes[curr_guard][m] += 1
		end
	end
end

sleepiest_guard = nil
max_times_slept = 0
sleepiest_minute = nil
sleep_minutes.each do |guard, h|
	h.each do |minute, count|
		if count > max_times_slept
			max_times_slept = count
			sleepiest_minute = minute
			sleepiest_guard = guard
		end
	end
end

puts sleepiest_guard.to_i * sleepiest_minute
