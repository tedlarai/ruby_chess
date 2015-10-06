module Pieces
  class King
    attr_reader(:icon_code, :color)
    def initialize(color)
      @color = color
      if color == "white"
        @icon_code = "\u2654"
      else
        @icon_code = "\u265A"
      end
    end

  #  def move_legal?(from, to)
  #    (from[0]-to[0]).abs <=1 && (from[1]-to[1]).abs <=1
  #  end

  #  def capture_legal?(from, to)
  #    move_legal?(from, to)
  #  end

  #  def path(a,b)#duckTyping
  #    []
  #  end
  end
end
