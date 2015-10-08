module RubyChess
  module MoveProccessor
    def proccess_move(command)
      @command = command
      @move = format_move
      proccessing_result = move_validity_with_message
      if proccessing_result[:validity] == true
        execute_move
      end
      proccessing_result
    end

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

    def format_move
      if ["0-0", "0-0-0"].include?(@command) #castling

      else
        move = @command.tr("a-h", "1-8").split("") - ["-"] # creates [from_col, from_row, to_col, to_row]
        [[move[0].to_i, move[1].to_i], [move[2].to_i, move[3].to_i]] # [from, to]
      end
    end

    def execute_move
      # update board, moves and captured_pieces, and ## or get_command ui message
      if @board[@move[1]] # destination is occupied -> capture
        @captured_pieces << @board[@move[1]]
        @command.sub!("-", " x ")
      end
      @moves << @command.sub("-", " - ")
      change_pieces_position
    end

    def change_pieces_position
      @board[@move[1]], @board[@move[0]] = @board[@move[0]], nil
    end

    def king_in_check?(player)
      other_player = other_color(player)
      @board.each do |k,v|
        if !v.nil? && v.color == other_player
          save_move = @move.dup
          @move = [k, king_position(player)]
          free_to_attack_the_king = move_validity_with_message(other_player)
          @move = save_move
          if free_to_attack_the_king[:validity]
            return true
          end
        end
      end
      false
    end

    def king_position(player)
      @board.each do |k,v|
        if v.instance_of?(Pieces::King) && v.color == player
          return k
        end
      end

    end
  end
end
