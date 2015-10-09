module RubyChess
  # end game : turn active_player to nil
  class GameState
    include MoveValidator
    include MoveProccessor
    attr_accessor :board, :moves, :captured_pieces, :active_player
    def initialize
      @board = gen_board
      @moves = Array.new
      @captured_pieces = Array.new
      @active_player = "white"
      @enpassant = nil
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

    def king_in_check?(player)
      other_player = other_color(player)
      @board.each do |k,v|
        if !v.nil? && v.color == other_player
          save_move = @move.dup
          @move = [k, king_position(player)]
          free_to_attack_the_king = move_validity_with_message(other_player)
          @move = save_move
          if free_to_attack_the_king[:validity]
            return true
          end
        end
      end
      false
    end

    def king_position(player)
      @board.each do |k,v|
        if v.instance_of?(Pieces::King) && v.color == player
          return k
        end
      end
    end

    def delivered_check?
      king_in_check?(other_color(@active_player))
    end

    def game_over?
      !has_legal_moves?(other_color(@active_player))
    end

    def has_legal_moves?(player)
      all_moves = @board.keys.product(@board.keys)
      all_moves.each do |move|
        @move = move
        if move_validity_with_message(player)[:validity]
          return true
        end
      end
      false
    end

  end
end
