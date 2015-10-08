module Pieces
  class Bishop
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "white"
        @icon_code = "\u2657"
      else
        @icon_code = "\u265D"
      end
    end

    def move_legal?(from, to)
      from[0]-to[0] == from[1]-to[1] || from[0]-to[0] == -(from[1]-to[1])
    end

    def capture_legal?(from, to)
      move_legal?(from, to)
    end

    def path(from, to)
      path_rows = Pieces.path_range(from[1], to[1])
      path_cols = Pieces.path_range(from[0], to[0])
      [path_cols, path_rows].transpose
    end

  end
end
