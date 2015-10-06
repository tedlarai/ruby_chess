module Pieces
  class Knight
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "white"
        @icon_code = "\u2658"
      else
        @icon_code = "\u265E"
      end
    end

    # def move_legal?(from, to)
    #   #divided in parts
    #   a = (from[0]-to[0] == -2 && (from[1]-to[1] == -1 || from[1]-to[1] == 1))
    #   b = (from[0]-to[0] == -1 && (from[1]-to[1] == -2 || from[1]-to[1] == 2))
    #   c = (from[0]-to[0] ==  1 && (from[1]-to[1] == -2 || from[1]-to[1] == 2))
    #   d = (from[0]-to[0] ==  2 && (from[1]-to[1] == -1 || from[1]-to[1] == 1))
    #   a||b||c||d
    # end

    # def capture_legal?(from, to)
    #   move_legal?(from, to)
    # end

    # def path(from, to) #duckTyping, no path for knight
    #   []
    # end
  end
end
