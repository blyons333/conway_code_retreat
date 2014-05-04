class Game
	attr_accessor :board

	def initialize(size)
		@size = size
		@board = Array.new(size) {|x| x = Array.new(size) {|y| y = Cell.new(0)}}
	end

	def play
		glider_coords = generate_random_glider
		seed_board(glider_coords)
		glider_coords2 = generate_random_glider
		seed_board(glider_coords2)
		glider_coords3 = generate_random_glider
		seed_board(glider_coords3)
		#seed_board([2,0], [2,1], [2,2], [1,2], [0,1])
		print_board
		while true
			system "clear" or system "cls"
			get_next_iteration
			print_board
			sleep(1.0/6.0)
		end
	end

	def print_board
		puts
		board.each_with_index {|row, row_index|
			if row_index == 0
				puts " *"*(@size)
			end
			row.each_with_index {|cell, cell_index|
				if cell_index == 0
					print "*"
				end
				if cell.current_state == 1
					print " o"
				else
					print "  "
				end
				if cell_index == @size-1
					print "*"
				end
			}
			puts
			if row_index == @size-1
				puts " *"*(@size)
			end
		}
	end

	def seed_board(coords)
		coords.each {|coord|
			x = coord[0]
			y = coord[1]
			board[x][y].current_state = 1
		}
	end

	def generate_random_glider
		rtn_coords = []
		possible_coords = *2.step(@size-1)
		top_right = possible_coords.sample
		#glider pattern:
		# -2 -1  0
		# =========
		#  -  -  x |  0
		#  x  -  x | -1
		#  -  x  x | -2
		# =========
		#[0,0]
		rtn_coords.push([top_right, top_right])
		#[0,-1]
		rtn_coords.push([top_right, top_right-1])
		#[0.-2]
		rtn_coords.push([top_right, top_right-2])
		#[-1, -2]
		rtn_coords.push([top_right-1, top_right-2])
		#[-2, -1]
		rtn_coords.push([top_right-2, top_right-1])
		return rtn_coords
	end

	def get_next_iteration
		set_next_cell_states
		board.each {|row| 
			row.each{|cell|
				cell.current_state = cell.next_state
				cell.next_state = 0
			}
		}
	end

	def set_next_cell_states
		board.each_with_index {|row, row_index|
			row.each_with_index{|cell, cell_index|
				num_neighbors = get_num_neighbors([row_index, cell_index])
				cell.set_next_state(num_neighbors)
			}
		}
	end

	def get_num_neighbors(coord)
		x = coord[0]
		y = coord[1]
		neighbor_count = 0
		rightNeigbor = x+1
		leftNeighbor = x-1
		topNeighbor = y-1
		bottomNeighbor = y+1

		if x+1 >= @size
			rightNeigbor = 0
		end
		if x-1 < 0
			leftNeighbor = @size-1
		end
		if y+1 >= @size
			bottomNeighbor = 0
		end
		if y-1 < 0 
			topNeighbor = @size-1
		end

		neighbor_count += board[rightNeigbor][y].current_state
		neighbor_count += board[leftNeighbor][y].current_state
		neighbor_count += board[x][bottomNeighbor].current_state
		neighbor_count += board[x][topNeighbor].current_state
		neighbor_count += board[rightNeigbor][bottomNeighbor].current_state
		neighbor_count += board[rightNeigbor][topNeighbor].current_state
		neighbor_count += board[leftNeighbor][bottomNeighbor].current_state
		neighbor_count += board[leftNeighbor][topNeighbor].current_state
		

		return neighbor_count
	end

end

class Cell
	attr_accessor :current_state, :next_state

	def initialize(current_state)
		@current_state = current_state
		@next_state = 0
	end

	def set_next_state(num_neighbors)
		#Rules --only setting if the next
		#state should change from the default of
		#dead to living
		if @current_state == 1 
			if num_neighbors > 1 and num_neighbors < 4
				@next_state = 1
			end
		else
			if num_neighbors == 3
				@next_state = 1
			end
		end
	end

end

my_game = Game.new(50)
my_game.play


