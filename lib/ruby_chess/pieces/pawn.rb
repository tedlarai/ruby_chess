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

    # def move_legal?(from, to) #hash keys{:from_row :from_col :from_row :to_col}
    #   if @color == "white"
    #     if from[0] == 2#starting position
    #      (to[0] == from[0] + 1 || to[0] == from[0] + 2) && to[1] == from[1]
    #     else #moved
    #       to[0] == from[0] + 1 && to[1] == from[1]
    #     end
    #   else #black
    #     if from[0] == 7 #starting position
    #       (to[0] == from[0] - 1 || to[0] == from[0] - 2) && to[1] == from[1]
    #     else #moved
    #       to[0] == from[0] - 1 && to[1] == from[1]
    #     end
    #   end
    # end
    #
    # def capture_legal?(from, to)
    #   if @color == 'white'
    #     to[0] == from[0] + 1 && (to[1] == from[1] + 1 || to[1] == from[1] - 1)
    #   else#black
    #     to[0] == from[0] - 1 && (to[1] == from[1] + 1 || to[1] == from[1] - 1)
    #   end
    # end
    # 
    # def path(from, to)
    #   path = []
    #   if (from[0]-to[0]).abs == 2
    #     path_row = (to[0]-from[0])/2 + from[0]
    #     path << [path_row, from[1]]
    #   end
    #   return path
    # end
  end
end
