module RubyChess
  class GameState
    attr_accessor :board, :moves, :captured_pieces
    def initialize
      @board = Array.new(8) { Array.new(8) }
      @moves = Array.new
      @captured_pieces = Array.new
      populate_board
    end

    def active_player
      # @moves.last.piece.color.change_color
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
  end
end
