puts File.read("input.txt").split("\n").map { |l| l.size - eval(l).size }.sum
