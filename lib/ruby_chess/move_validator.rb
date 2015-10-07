module RubyChess
  module MoveValidator
    def default_response
      { validity: true, message: "" }
    end

    def move_to_different_tile?(*args)
      if @move[0] == @move[1]
        {validity: false, message: Messages.same_tile_move(@command)}
      else
        default_response
      end
    end

    def tile_of_origin_has_a_piece?(piece)
      unless piece
        {validity: false, message: Messages.empty_origin_tile(@command)}
      else
        default_response
      end
    end

    def piece_has_same_color_as_player?(piece)
      unless piece.color == @active_player
        {validity: false, message: Messages.wrong_color(@command)}
      else
        default_response
      end
    end

    def capture_try?
      !@board[@move[1]].nil?
    end

    def not_capturing_own_piece?(*args)
      unless capture_try? &&  @board[@move[1]].color != @active_player
        {validity: false, message: Messages.capturing_own_piece(@command)}
      else
        default_response
      end
    end
  end
end
