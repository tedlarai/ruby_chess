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

  #  def path(from, to)
  #    path = []
  #    if from[0] == to[0]#same row
  #      aux = Bishop.path_range(from[1], to[1])
  #      aux.each {|x| path << [from[0], x]}
  #    else#same col
  #      aux = Bishop.path_range(from[0], to[0])
  #      aux.each {|x| path << [x,from[1]]}
  #    end
  #    return path
  #  end
  end
end
