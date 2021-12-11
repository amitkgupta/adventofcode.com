aim, h, d = 0, 0, 0
File.read("input.txt").split("\n").each do |l|
    dir, dist_str = l.split(" ")
    dist = dist_str.to_i
    case dir
    when "forward"
        h += dist
        d += aim * dist
    when "up"
        aim -= dist
    when "down"
        aim += dist
    end
end
puts h * d
