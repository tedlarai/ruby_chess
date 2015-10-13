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
        @command.dup
      else
        move = @command.tr("a-h", "1-8").split("") - ["-"] # creates [from_col, from_row, to_col, to_row]
        [[move[0].to_i, move[1].to_i], [move[2].to_i, move[3].to_i]] # [from, to]
      end
    end

    def execute_move
      if @command == "0-0"
        @moves << @command
        short_castling
      elsif @command == "0-0-0"
        @moves << @command
        long_castling
      elsif @move[1] == @enpassant[0] && @enpassant[1] # enpassant
        @captured_pieces << @board[@enpassant[1]]
        @moves << @command.sub("-", " ep ")
        change_pieces_position
        @board[@enpassant[1]] = nil
        verify_and_update_enpassant_tile
      else # not castling nor enpassant
        if @board[@move[1]] # destination is occupied -> capture
          @captured_pieces << @board[@move[1]]
          @command.sub!("-", " x ")
        end
        @moves << @command.sub("-", " - ")
        change_pieces_position
        verify_and_update_enpassant_tile
      end
    end

    def change_pieces_position
      @board[@move[1]], @board[@move[0]] = @board[@move[0]], nil
    end

    def verify_and_update_enpassant_tile
      piece = @board[@move[1]]
      path = piece.path(@move[0], @move[1])
      if (piece.class == Pieces::Pawn) && !path.empty?
        @enpassant = [path[0], @move[1]]
      else
        @enpassant = [nil, nil]
      end
    end

    def short_castling
      @active_player == "white" ? row = 1 : row = 8
      @board[[5, row]], @board[[6, row]], @board[[7, row]], @board[[8, row]] = nil, @board[[8, row]], @board[[5, row]], nil
    end

    def long_castling
      @active_player == "white" ? row = 1 : row = 8
      @board[[5, row]], @board[[4, row]], @board[[3, row]], @board[[1, row]] = nil, @board[[1, row]], @board[[5, row]], nil
    end
  end
end
