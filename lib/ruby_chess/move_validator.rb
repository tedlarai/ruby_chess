module RubyChess
  module MoveValidator
    def move_validity_with_message(player = @active_player)
      if ["0-0", "0-0-0"].include?(@move) #castling
        validate_castling(player)
      else
        validate_move(player)
      end
    end

    def validate_castling(player)
      player == "white" ? row = 1 : row = 8
      @move == "0-0" ? rook_col = 8 : rook_col = 1

      validators_list = [
        ["correct_pieces_and_not_moved?", row, rook_col],
        ["no_pieces_between?", row, rook_col],
        ["king_not_passing_through_check?", row, rook_col]
      ]
      validity_with_message = {}
      validators_list.detect do |method, arg1, arg2|
        validity_with_message = send(method, arg1, arg2)
        !validity_with_message[:validity]
      end
      validity_with_message
    end

    def validate_move(player)
      piece_to_move = @board[@move[0]]

      validators_list = [
        ["move_to_different_tile?"],
        ["tile_of_origin_has_a_piece?", piece_to_move],
        ["piece_has_same_color_as_player?", piece_to_move, player],
        ["not_capturing_own_piece?", player],
        ["piece_capable_of_move?", piece_to_move],
        ["not_jumping_other_pieces?", piece_to_move],
        ["not_leaving_own_king_in_check?", player]
      ]
      validity_with_message = {}
      validators_list.detect do |method, arg1, arg2|
        validity_with_message = send(method, arg1, arg2)
        !validity_with_message[:validity]
      end
      validity_with_message
    end

    def default_response
      { validity: true, message: Messages.successful_move(@command) }
    end

    def correct_pieces_and_not_moved?(row, rook_col)
      @moves.each_with_index do |move, i|
        if move.include?("e#{row}") # king moved
          return {validity: false, message: Messages.king_moved(@command)}
        elsif move.include?("#{rook_col}#{row}") # rook moved or was captured
          return {validity: false, message: Messages.rook_moved_or_captured(@command)}
        elsif move.include?("0-") && (i.odd? == @moves.length.odd?)
          return {validity: false, message: Messages.already_castled(@command)}
        end
      end
      default_response
    end

    def no_pieces_between?(row, rook_col)
      rook_col == 1 ? cols_between = [2, 3, 4] : cols_between = [6, 7]
      tiles_between = []
      cols_between.each do |col|
        tiles_between << [col, row]
      end
      tiles_between.each do |tile|
        if @board[tile]
          return {validity: false, message: Messages.piece_between_king_and_rook(@command, @board[tile])}
        end
      end
      default_response
    end

    def king_not_passing_through_check?(row, rook_col)
      rook_col == 1 ? path_cols = [4, 3] : path_cols = [6, 7]
      row == 1 ? player = "white" : player = "black"
      if king_in_check?(player)
        return {validity: false, message: Messages.king_under_attack(@command)}
      end
      king_path = []
      path_cols.each { |col| king_path << [col,row]}

      moves = [[[5,row], king_path[0]], [king_path[0], king_path[1]]]
      save_move, save_board = @move.dup, @board.dup
      validity = default_response
      moves.each do |move|
        @move = move
        change_pieces_position
        check = king_in_check?(player)
        if check
          validity = {validity: false, message: Messages.king_would_be_attacked(@command, @move[1])}
          break
        end
      end
      @move, @board, = save_move, save_board
      validity
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
      tile_empty = @board[@move[1]].nil?
      piece = @board[@move[0]]
      (!tile_empty) || (piece.class == Piece::Pawn && @move[1] == @enpassant)         
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

    def not_leaving_own_king_in_check?(player, *args)
      # the next 'if' reflects the fact that is legal to expose own king to
      # imediately capture the other king.
      # This situation dont arise in games, but the
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
