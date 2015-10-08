module RubyChess
  # end game : turn active_player to nil
  class GameState
    include MoveValidator
    attr_accessor :board, :moves, :captured_pieces, :active_player
    def initialize
      @board = gen_board
      @moves = Array.new
      @captured_pieces = Array.new
      @active_player = "white"
      fill_board
    end

    def gen_board
      rows = Array(1..8)
      cols = Array(1..8)
      tiles = cols.product(rows)
      Hash[tiles.map { |tile| [tile, nil]}]
    end

    def other_color(color)
      if color == "white"
        "black"
      else
        "white"
      end
    end

    def switch_active_player
      @active_player = other_color(@active_player)
    end

    def fill_board
      (1..8).each do |col|
        @board[[col,2]] = Pieces::Pawn.new("white")
        @board[[col,7]] = Pieces::Pawn.new("black")
      end
      @board[[1, 1]] = Pieces::Rook.new("white")
      @board[[2, 1]] = Pieces::Knight.new("white")
      @board[[3, 1]] = Pieces::Bishop.new("white")
      @board[[4, 1]] = Pieces::Queen.new("white")
      @board[[5, 1]] = Pieces::King.new("white")
      @board[[6, 1]] = Pieces::Bishop.new("white")
      @board[[7, 1]] = Pieces::Knight.new("white")
      @board[[8, 1]] = Pieces::Rook.new("white")
      @board[[1, 8]] = Pieces::Rook.new("black")
      @board[[2, 8]] = Pieces::Knight.new("black")
      @board[[3, 8]] = Pieces::Bishop.new("black")
      @board[[4, 8]] = Pieces::Queen.new("black")
      @board[[5, 8]] = Pieces::King.new("black")
      @board[[6, 8]] = Pieces::Bishop.new("black")
      @board[[7, 8]] = Pieces::Knight.new("black")
      @board[[8, 8]] = Pieces::Rook.new("black")
    end

    def proccess_move(command)
      @command = command
      proccessing_result = move_validity_with_message
      if proccessing_result[:validity] == true
        execute_move
      end
      proccessing_result
    end

    def move_validity_with_message
      if ["0-0", "0-0-0"].include?(@command) #castling

      else
        @move = format_move
        piece_to_move = @board[@move[0]]

        validators_list = [
                           ["move_to_different_tile?"],
                           ["tile_of_origin_has_a_piece?", piece_to_move],
                           ["piece_has_same_color_as_player?", piece_to_move],
                           ["not_capturing_own_piece?"],
                           ["piece_capable_of_move?", piece_to_move],
                           ["not_jumping_other_pieces?", piece_to_move]
                          ]
        validity_with_message = {}
        validators_list.detect do |method, args|
          validity_with_message = send(method, args)
          !validity_with_message[:validity]
        end
      end
      validity_with_message
    end

    def format_move
      move = @command.tr("a-h", "1-8").split("") - ["-"] # creates [from_col, from_row, to_col, to_row]
      [[move[0].to_i, move[1].to_i], [move[2].to_i, move[3].to_i]] # [from, to]
    end

    def execute_move
      # update board, moves and captured_pieces, and ## or get_command ui message
    end
  end
end
