require_relative "../operations.rb"

SAMPLE_REGEX = /(\d+), (\d+), (\d+), (\d+)..(\d+) (\d+) (\d+) (\d+).*(\d+), (\d+), (\d+), (\d+)/m

class Sample
	OPERATIONS = [:addr, :addi, :mulr, :muli, :banr, :bani, :borr, :bori, :setr, :seti, :gtir, :gtri, :gtrr, :eqir, :eqri, :eqrr]

	attr_reader :opscode_number

	def initialize(ir0, ir1, ir2, ir3, on, a, b, c, or0, or1, or2, or3)
		@input_register = [ir0, ir1, ir2, ir3]
		@opscode_number = on
		@a = a
		@b = b
		@c = c
		@output_register = [or0, or1, or2, or3]
	end

	def possible_operations
		OPERATIONS.select { |i| send(i, @input_register, @a, @b, @c) == @output_register }
	end
end

texts = File.read("input.txt").split("\n\n").reject(&:empty?)
program = texts.pop.split("\n").map { |l| l.split(" ").map(&:to_i) }
opscode_possibilities = texts.
	map { |txt| Sample.new(*(txt.match(SAMPLE_REGEX)[1, 12].map(&:to_i))) }.
	group_by(&:opscode_number).
	map { |k, v| [k, v.map(&:possible_operations).inject(&:&)] }.
	to_h
opscode_map = {}
until opscode_possibilities.values.all?(&:empty?) do
	opscode_possibilities.each { |k,v| opscode_map[k] = v.first if v.size == 1 }
	opscode_possibilities.each { |k,v| opscode_possibilities[k] = v - opscode_map.values }
end

puts program.inject([0, 0, 0, 0]) { |reg, instr| send(opscode_map[instr.shift], reg, *instr) }.first