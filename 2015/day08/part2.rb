puts File.read("input.txt").split("\n").map { |l| 2 + l.count(?") + l.count(?\\) }.sum
