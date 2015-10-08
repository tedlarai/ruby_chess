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

  end
end
