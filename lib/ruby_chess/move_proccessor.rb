module RubyChess
  module MoveProccessor
    def proccess_move(command)
      @command = command
      proccessing_result = move_validity_with_message
      if proccessing_result[:validity] == true
        execute_move
      end
      proccessing_result
    end

    def move_validity_with_message
      if ["0-0", "0-0-0"].include?(@command) #castling

      else
        @move = format_move
        piece_to_move = @board[@move[0]]

        validators_list = [
                           ["move_to_different_tile?"],
                           ["tile_of_origin_has_a_piece?", piece_to_move],
                           ["piece_has_same_color_as_player?", piece_to_move],
                           ["not_capturing_own_piece?"],
                           ["piece_capable_of_move?", piece_to_move],
                           ["not_jumping_other_pieces?", piece_to_move],
                           ["leaving_tile_between_kings?", piece_to_move],
                           # ["not_leaving_own_king_in_check?"]
                          ]
        validity_with_message = {}
        validators_list.detect do |method, args|
          validity_with_message = send(method, args)
          !validity_with_message[:validity]
        end
      end
      validity_with_message
    end

    def format_move
      move = @command.tr("a-h", "1-8").split("") - ["-"] # creates [from_col, from_row, to_col, to_row]
      [[move[0].to_i, move[1].to_i], [move[2].to_i, move[3].to_i]] # [from, to]
    end

    def execute_move
      # update board, moves and captured_pieces, and ## or get_command ui message
      if @board[@move[1]] # destination is occupied -> capture
        @captured_pieces << @board[@move[1]]
        @command.sub!("-", " x ")
      end
      @moves << @command.sub("-", " - ")
      @board[@move[1]], @board[@move[0]] = @board[@move[0]], nil
    end
  end
end
