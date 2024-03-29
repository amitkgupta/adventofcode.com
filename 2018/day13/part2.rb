class Cart
	attr_reader :x, :y, :orientation

	include Comparable

	def initialize(x, y, orientation)
		@x, @y, @orientation, @next_turn = x, y, orientation, :left
	end

	def move_on(track)
		case @orientation
		when ?>
			@x += 1
		when ?<
			@x -= 1
		when ?^
			@y -= 1
		when ?v
			@y += 1
		end

		case [track, @orientation]
		when [?/, ?>]
			@orientation = ?^
		when [?/, ?v]
			@orientation = ?<
		when [?/, ?<]
			@orientation = ?v
		when [?/, ?^]
			@orientation = ?>
		when [?\\, ?>]
			@orientation = ?v
		when [?\\, ?v]
			@orientation = ?>
		when [?\\, ?<]
			@orientation = ?^
		when [?\\, ?^]
			@orientation = ?<
		end

		return unless track == ?+

		case [@next_turn, @orientation]
		when [:left, ?>]
			@orientation = ?^
		when [:left, ?v]
			@orientation = ?>
		when [:left, ?<]
			@orientation = ?v
		when [:left, ?^]
			@orientation = ?<
		when [:right, ?>]
			@orientation = ?v
		when [:right, ?v]
			@orientation = ?<
		when [:right, ?<]
			@orientation = ?^
		when [:right, ?^]
			@orientation = ?>
		end

		case @next_turn
		when :left
			@next_turn = :straight
		when :straight
			@next_turn = :right
		when :right
			@next_turn = :left
		end
	end

	def <=>(other_cart)
		v = (@y <=> other_cart.y)
		v.zero? ? @x <=> other_cart.x : v
	end
end

class Map
	def initialize(path)
		@grid = File.read(path).gsub(/(\^|v)/, ?|).gsub(/(<|>)/, ?-).split("\n")
	end

	def next_track(x, y, orientation)
		case orientation
		when ?>
			@grid[y][x+1]
		when ?<
			@grid[y][x-1]
		when ?^
			@grid[y-1][x]
		when ?v
			@grid[y+1][x]
		end
	end
end

class Carts
	def initialize(path)
		@carts = []
		rows = File.read(path).split("\n")
		rows.each_index do |y|
			chars = rows[y].chars
			chars.each_index do |x|
				char = chars[x]
				@carts << Cart.new(x, y, char) if [?>, ?<, ?^, ?v].include?(char)
			end
		end
	end

	def move_on(map)
		i = 0
		loop do
			if i >= @carts.length
				break
			end

			cart = @carts[i]
			cart.move_on(map.next_track(cart.x, cart.y, cart.orientation))
			colliding_cart_index = (@carts - [cart]).index { |other_cart| cart == other_cart }
			if colliding_cart_index.nil?
				i += 1
			else
				@carts.delete_at(colliding_cart_index)
				@carts.delete(cart)
				i -= 1 if colliding_cart_index < i
			end
		end

		if @carts.size == 1
			cart = @carts.first
			return cart.x, cart.y
		else
			@carts.sort!
			return nil
		end
	end
end

inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"
map = Map.new(inp_file)
carts = Carts.new(inp_file)

loop do
	if coords = carts.move_on(map)
		print coords.join(?,)
		puts
		break
	end
end
