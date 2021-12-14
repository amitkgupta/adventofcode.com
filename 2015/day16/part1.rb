sues = {}
File.read("input.txt").split("\n").each do |l|
	sue, attrs = l.split(": ", 2)
	num = sue.match(/\d+/)[0]
	sues[num] = attrs.split(", ").map { |attr| attr.split(": ") }.to_h
end

mfcsam_output = {
	"children" => "3",
	"cats" => "7",
	"samoyeds" => "2",
	"pomeranians" => "3",
	"akitas" => "0",
	"vizslas" => "0",
	"goldfish" => "5",
	"trees" => "3",
	"cars" => "2",
	"perfumes" => "1",
}

sues.each do |sue, attrs|
	next if attrs.any? { |k,v| v != mfcsam_output[k] } 
	puts sue
	break
end
