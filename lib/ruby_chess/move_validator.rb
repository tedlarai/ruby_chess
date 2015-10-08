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
      print (!@board[@move[1]].nil?)
      !@board[@move[1]].nil?
    end

    def not_capturing_own_piece?(*args)
      if capture_try? &&  @board[@move[1]].color == @active_player
        {validity: false, message: Messages.capturing_own_piece(@command)}
      else
        default_response
      end
    end

    def piece_capable_of_move?(piece)
      unless capture_try? #no capture
        unless piece.move_legal?(@move[0], @move[1])
          {validity: false, message: Messages.piece_not_capable_of_move(piece, @command)}
        else
          default_response
        end
      else #capture
        unless piece.capture_legal?(@move[0], @move[1])
          {validity: false, message: Messages.piece_not_capable_of_capture(piece, @command)}
        else
          default_response
        end
      end
    end

    def not_jumping_other_pieces?(piece)
      path = piece.path(@move[0], @move[1])
      path.each do |tile|
        unless @board[tile].nil?
          return {validity: false, message: Messages.piece_cannot_jump(piece, tile, @command)}
        end
      end
      default_response
    end

    def leaving_tile_between_kings?(piece)
      to = @move[1]
      if piece.instance_of?(Pieces::King)
        other_king_position = nil
        @board.each do |k,v|
          if (v.instance_of?(King) && !(v.equal?(piece)))
            other_king_position = k
            break
          end
        end
        if (other_king_position[0] - to[0]).abs <= 1 || (other_king_position[1] - to[1]).abs <= 1
          return {validity: false, message: Messages.king_near_other_king(@command)}
        end
      end
      default_response
    end

  end
end
