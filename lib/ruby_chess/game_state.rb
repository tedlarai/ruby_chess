module RubyChess
  # end game : turn active_player to nil
  class GameState
    include MoveValidator
    attr_accessor :board, :moves, :captured_pieces, :active_player
    def initialize
      @board = Array.new(8) { Array.new(8) }
      @moves = Array.new
      @captured_pieces = Array.new
      @active_player = "white"
      populate_board
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

    def populate_board
      @board.map! do |col|
        col[1] = Pieces::Pawn.new("white")
        col[6] = Pieces::Pawn.new("black")
        col
      end
      @board[0][0] = Pieces::Rook.new("white")
      @board[1][0] = Pieces::Knight.new("white")
      @board[2][0] = Pieces::Bishop.new("white")
      @board[3][0] = Pieces::Queen.new("white")
      @board[4][0] = Pieces::King.new("white")
      @board[5][0] = Pieces::Bishop.new("white")
      @board[6][0] = Pieces::Knight.new("white")
      @board[7][0] = Pieces::Rook.new("white")
      @board[0][7] = Pieces::Rook.new("black")
      @board[1][7] = Pieces::Knight.new("black")
      @board[2][7] = Pieces::Bishop.new("black")
      @board[3][7] = Pieces::Queen.new("black")
      @board[4][7] = Pieces::King.new("black")
      @board[5][7] = Pieces::Bishop.new("black")
      @board[6][7] = Pieces::Knight.new("black")
      @board[7][7] = Pieces::Rook.new("black")
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
        format_move
        piece_to_move = @board[@move[0][0]][@move[0][1]]

        validators_list = [
                           ["move_to_different_tile?"],
                           ["tile_of_origin_has_a_piece?", piece_to_move],
                           ["piece_has_same_color_as_player?", piece_to_move],
                           ["not_capturing_own_piece?"]
                          ]
        validity_with_message = {}
        validators_list.detect do |method|
          validity_with_message = send(method[0], method[1])
          !validity_with_message[:validity]
        end
      end
      validity_with_message
    end

    def format_move
      @move = @command.tr("1-8", "0-7").tr("a-h", "0-7").split("-")
      @move.map!{|x| x.split("").map{|z| z.to_i}}
    end

    def execute_move
      # update board, moves and captured_pieces, and ## or get_command ui message
    end
  end
end
