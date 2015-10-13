module Pieces
  class Pawn
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "black"
        @icon_code = "\u265F"
      else
        @icon_code = "\u2659"
      end
    end

    def move_legal?(from, to)
      if @color == "white"
        if from[1] == 2#starting position
         (to[1] == from[1] + 1 || to[1] == from[1] + 2) && to[0] == from[0]
        else #moved
          to[1] == from[1] + 1 && to[0] == from[0]
        end
      else #black
        if from[1] == 7 #starting position
          (to[1] == from[1] - 1 || to[1] == from[1] - 2) && to[0] == from[0]
        else #moved
          to[1] == from[1] - 1 && to[0] == from[0]
        end
      end
    end

    def capture_legal?(from, to)
      if @color == 'white'
        to[1] == from[1] + 1 && (to[0] == from[0] + 1 || to[0] == from[0] - 1)
      else # black
        to[1] == from[1] - 1 && (to[0] == from[0] + 1 || to[0] == from[0] - 1)
      end
    end

    def path(from, to)
      if (from[1]-to[1]).abs == 2 # 2 tile advance
        path_row = (to[1]-from[1])/2 + from[1]
        [[from[0], path_row]]
      else # normal move
        []
      end
    end
  end
end
