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
  #
  #  def path(from, to)
  #    path = []
  #    if from[0] == to[0] || from[1] == to[1] ##rook-like move
  #      if from[0] == to[0]#same row
  #        aux = Bishop.path_range(from[1], to[1])
  #        aux.each {|x| path << [from[0], x]}
  #      else#same col
  #        aux = Bishop.path_range(from[0], to[0])
  #        aux.each {|x| path << [x,from[1]]}
  #      end
  #      return path
  #    else ##bishop like move
  #      path_rows = Bishop.path_range(from[0], to[0])
  #      path_cols = Bishop.path_range(from[1], to[1])
  #      path_rows.each_with_index {|x,i| path << [x, path_cols[i]]}
  #      return path
  #    end
  #  end
  end
end
