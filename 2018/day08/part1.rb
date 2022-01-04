class Node
	attr_writer :remaining_children, :remaining_metadata

	def initialize
		@children = []
		@metadata = []
	end

	def add_child(node)
		@children << node
		@remaining_children -= 1
	end

	def has_all_children?
		@remaining_children.zero?
	end

	def add_metadata(data)
		@metadata << data
		@remaining_metadata -= 1
	end

	def has_all_metadata?
		@remaining_metadata.zero?
	end

	def value
		@metadata.inject(0,&:+) + @children.map(&:value).inject(0,&:+)
	end
end

class NodesInProgress
	def initialize
		@nodes = []
	end

	def add(node)
		@nodes << node
	end

	def set_remaining_metadata_for_current(n)
		current.remaining_metadata = n
	end

	def set_remaining_children_for_current(n)
		current.remaining_children = n
	end

	def current_has_all_children?
		current.has_all_children?
	end

	def current_has_all_metadata?
		current.has_all_metadata?
	end

	def add_child_to_current(node)
		current.add_child(node)
	end

	def add_metadata_to_current(data)
		current.add_metadata(data)
	end

	def finished?
		@nodes.empty?
	end

	def finish_current
		@nodes.pop
	end

	private

	def current
		@nodes.last
	end
end

def build_tree(license)
	nodes_in_progress = NodesInProgress.new

	at_child_count = true
	at_metadata_count = false

	license.each do |n|
		if at_child_count
			nodes_in_progress.add(Node.new)
			nodes_in_progress.set_remaining_children_for_current(n)
			at_child_count = false
			at_metadata_count = true
			next
		end

		if at_metadata_count
			nodes_in_progress.set_remaining_metadata_for_current(n)
			at_metadata_count = false
			at_child_count = true unless nodes_in_progress.current_has_all_children?
		else
			nodes_in_progress.add_metadata_to_current(n)
		end

		if nodes_in_progress.current_has_all_metadata?
			finished_node = nodes_in_progress.finish_current
			if nodes_in_progress.finished?
				return finished_node
			else
				nodes_in_progress.add_child_to_current(finished_node)
				at_child_count = true unless nodes_in_progress.current_has_all_children?
			end
		end
	end
end

root = build_tree(File.read("input.txt").split.map(&:to_i))
puts root.value
