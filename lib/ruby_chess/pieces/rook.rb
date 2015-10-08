module Pieces
  class Rook
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "white"
        @icon_code = "\u2656"
      else
        @icon_code = "\u265C"
      end
    end

    def move_legal?(from, to)
      from[0] == to[0] || from[1] == to[1]
    end

    def capture_legal?(from, to)
      move_legal?(from, to)
    end

    def path(from, to)
      if from[1] == to[1] # same row
        Pieces.path_range(from[0], to[0]).map{|col| [col, from[1]]}
      else # same col
        Pieces.path_range(from[1], to[1]).map{|row| [from[0], row]}
      end
    end
  end
end
