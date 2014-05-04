class Game
	attr_accessor :board

	def initialize(size)
		@board = Array.new(size) { |x| x = Array.new(size) {|y| y = Cell.new(false)} }
	end

	# [x1,y1], [x2,y2]
	def add_live_cells(*coords)
		coords.each do |x|
			@board[x[0]][x[1]].living = true
		end
	end

	def print_board
		@board.each do |row|
			p row
		end
	end

	def get_neighbors(cell)
		x = cell[0]
		y = cell[1]
		truth_array = [] 
		array = [[x + 1,y], [x, y + 1], [x+1, y+1], [x-1, y-1], [x-1, y], [x, y-1], [x +1, y-1], [x-1, y+1]]
		array.each do |coord|
			this_cell = (board[coord[0]][coord[1]])
			if this_cell != nil
				if (board[coord[0]][coord[1]]).living == true
					truth_array.push((board[coord[0]][coord[1]]).living)
				end
			end
		end
		return  truth_array.count
	end

	# def apply_rules(cell)
	
	# end


	def iterate_through_board
	end

	def next_board

	end



end

class Cell
	attr_accessor :living

	def initialize(living)
		@living = living
	end
end

game = Game.new(3)
game.add_live_cells([0,0], [0,1])
game.print_board

puts "THIS IS THE THING"
p game.get_neighbors([1,1])
p game.get_neighbors([0,0])
p game.get_neighbors([1,2])



#COMPLETE
#able to return a count of the number of 'alive' neighbors for any given cell

#THINGS TO DO
#apply the rules based on the number of alive neighbors
#pass new objects to a new board based on the evaluation of the rules while iteratin through @board




