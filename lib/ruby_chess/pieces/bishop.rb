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

    # def path(from, to)
    #   path = []
    #   path_rows = Bishop.path_range(from[0], to[0])
    #   path_cols = Bishop.path_range(from[1], to[1])
    #   path_rows.each_with_index {|x,i| path << [x, path_cols[i]]}
    #   return path
    # end

    # def Bishop.path_range(num1, num2) #returns all numbers between them, in the same order as nums
    #   path = []
    #   if num1 > num2
    #     return Bishop.path_range(num2, num1).reverse
    #   else
    #     c = num1+1
    #     while c < num2
    #       path << c
    #       c += 1
    #     end
    #     return path
    #   end
    # end

  end
end
