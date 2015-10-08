module Pieces
  class Queen
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "white"
        @icon_code = "\u2655"
      else
        @icon_code = "\u265B"
      end
    end

    def move_legal?(from, to)
      l_bishop = from[0]-to[0] == from[1]-to[1] || from[0]-to[0] == -(from[1]-to[1])
      l_rook = from[0] == to[0] || from[1] == to[1]
      l_bishop || l_rook
    end

    def capture_legal?(from, to)
      move_legal?(from, to)
    end

    def path(from, to)
      if from[0] == to[0] || from[1] == to[1] # rook-like move
        if from[1] == to[1] # same row
          Pieces.path_range(from[0], to[0]).map{|col| [col, from[1]]}
        else # same col
          Pieces.path_range(from[1], to[1]).map{|row| [from[0], row]}
        end
      else # bishop-like move
        path_rows = Pieces.path_range(from[1], to[1])
        path_cols = Pieces.path_range(from[0], to[0])
        [path_cols, path_rows].transpose
      end
    end
  end
end
