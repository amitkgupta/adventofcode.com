inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sections = File.read(inp_file).split("\n\n")

seeds = sections[0].split(?:)[1].split.map(&:to_i)

def parse_section(section)
	section.split(":\n")[1].split("\n").map { |l| l.split.map(&:to_i) }
end

setoso = parse_section(sections[1])
sotofe = parse_section(sections[2])
fetowa = parse_section(sections[3])
watoli = parse_section(sections[4])
litote = parse_section(sections[5])
tetohu = parse_section(sections[6])
hutolo = parse_section(sections[7])

locs = seeds.map do |se|
	i = setoso.index { |ins| se >= ins[1] && se < ins[1] + ins[2] }
	so = i.nil? ? se : setoso[i][0] + (se - setoso[i][1])

	i = sotofe.index { |ins| so >= ins[1] && so < ins[1] + ins[2] }
	fe = i.nil? ? so : sotofe[i][0] + (so - sotofe[i][1])

	i = fetowa.index { |ins| fe >= ins[1] && fe < ins[1] + ins[2] }
	wa = i.nil? ? fe : fetowa[i][0] + (fe - fetowa[i][1])

	i = watoli.index { |ins| wa >= ins[1] && wa < ins[1] + ins[2] }
	li = i.nil? ? wa : watoli[i][0] + (wa - watoli[i][1])

	i = litote.index { |ins| li >= ins[1] && li < ins[1] + ins[2] }
	te = i.nil? ? li : litote[i][0] + (li - litote[i][1])

	i = tetohu.index { |ins| te >= ins[1] && te < ins[1] + ins[2] }
	hu = i.nil? ? te : tetohu[i][0] + (te - tetohu[i][1])

	i = hutolo.index { |ins| hu >= ins[1] && hu < ins[1] + ins[2] }
	i.nil? ? hu : hutolo[i][0] + (hu - hutolo[i][1])
end

puts locs.min