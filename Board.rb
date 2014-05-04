class Board
	attr_reader :board_array

	def initialize(board_size)
		@board_array = Array.new(board_size) {|a| Array.new(board_size) {|b| Cell.new}}
	end


	
end

class Game
	attr_reader :board


	def initialize
		@board = Board.new(3)
	end

end

class Cell

	attr_reader :living

	def initialize
		@living = false
	end

end


britneys_game = Game.new
puts britneys_game.class == Game
puts britneys_game.board.class == Board
# puts britneys_game.board.board_array == [[nil, nil,nil],[nil, nil,nil],[nil, nil,nil]]
p britneys_game.board.board_array
britneys_cell = Cell.new
puts britneys_cell.living == false