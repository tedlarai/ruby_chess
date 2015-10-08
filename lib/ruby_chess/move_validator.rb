module RubyChess
  module MoveValidator
    def move_validity_with_message(player = @active_player)
      if ["0-0", "0-0-0"].include?(@command) #castling
        # blabla
      else
        piece_to_move = @board[@move[0]]

        validators_list = [
                           ["move_to_different_tile?"],
                           ["tile_of_origin_has_a_piece?", piece_to_move],
                           ["piece_has_same_color_as_player?", piece_to_move, player],
                           ["not_capturing_own_piece?", player],
                           ["piece_capable_of_move?", piece_to_move],
                           ["not_jumping_other_pieces?", piece_to_move],
                           ["leaving_tile_between_kings?", piece_to_move],
                           ["not_leaving_own_king_in_check?", player]
                          ]
        validity_with_message = {}
        validators_list.detect do |method, arg1, arg2|
          validity_with_message = send(method, arg1, arg2)
          !validity_with_message[:validity]
        end
      end
      validity_with_message
    end

    def default_response
      { validity: true, message: Messages.successful_move(@command) }
    end

    def move_to_different_tile?(*args)
      if @move[0] == @move[1]
        {validity: false, message: Messages.same_tile_move(@command)}
      else
        default_response
      end
    end

    def tile_of_origin_has_a_piece?(piece, *args)
      unless piece
        {validity: false, message: Messages.empty_origin_tile(@command)}
      else
        default_response
      end
    end

    def piece_has_same_color_as_player?(piece, player)
      unless piece.color == player
        {validity: false, message: Messages.wrong_color(@command)}
      else
        default_response
      end
    end

    def capture_try?
      !@board[@move[1]].nil?
    end

    def not_capturing_own_piece?(player, *args)
      if capture_try? &&  @board[@move[1]].color == player
        {validity: false, message: Messages.capturing_own_piece(@command)}
      else
        default_response
      end
    end

    def piece_capable_of_move?(piece, *args)
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

    def not_jumping_other_pieces?(piece, *args)
      path = piece.path(@move[0], @move[1])
      path.each do |tile|
        unless @board[tile].nil?
          return {validity: false, message: Messages.piece_cannot_jump(piece, tile, @command)}
        end
      end
      default_response
    end

    def leaving_tile_between_kings?(piece, *args)
      to = @move[1]
      if piece.instance_of?(Pieces::King)
        other_king_position = king_position(other_color(piece.color))

        if (other_king_position[0] - to[0]).abs <= 1 || (other_king_position[1] - to[1]).abs <= 1
          return {validity: false, message: Messages.king_near_other_king(@command)}
        end
      end
      default_response
    end

    def not_leaving_own_king_in_check?(player, *args)
      # the next 'if' reflects the fact that is legal to expose own king to directly
      # capture the other king. This situation dont arise in games, but the
      # concept is necessary to solve the problem where a piece tries to leave
      # its own king in check and deliver check itself. Without this theoretical
      # provision, the validation of this move would become an infinite loop
      if @move[1] == king_position(other_color(player))
        return default_response
      end

      save_board = @board.dup
      change_pieces_position
      check = king_in_check?(player)
      @board = save_board

      if check
        {validity: false, message: Messages.own_king_in_check(@command)}
      else
        default_response
      end
    end
  end
end
