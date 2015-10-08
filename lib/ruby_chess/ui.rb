# encoding: UTF-8

module RubyChess
  class UI
    def initialize(game_state)
      @template = File.open((File.expand_path("../ui_template.txt", __FILE__)), "r", &:read)
      @template.freeze
      @game_state = game_state
    end

    def update_view(message)
      @message = message
      system 'clear'
      populate_template
      print @filled_template
    end

    def populate_template
      @filled_template = @template.dup
      @filled_template.sub!("message", "#{@message}")
      populate_pieces
      populate_captured_pieces
      populate_last_moves
      populate_prompt
    end

    def populate_pieces
      ("A".."H").each_with_index do |col, col_index|
        (1..8).each do |row|
          piece = @game_state.board[[col_index + 1, row]]
          if piece.nil?
            @filled_template.sub!("#{col}#{row}", "  ")
          else
            @filled_template.sub!("#{col}#{row}", "#{piece.icon_code} ")
          end
        end
      end
    end

    def populate_captured_pieces
      white_captured = @game_state.captured_pieces.select {|piece| piece.color == 'white'}
      black_captured = @game_state.captured_pieces - white_captured
      (1..16).each do |index|
        if white_captured[index-1].nil?
          @filled_template.sub!("wp#{index}", " ")
        else
          @filled_template.sub!("wp#{index}", "#{white_captured[index-1].icon_code}")
        end
        if black_captured[index-1].nil?
          @filled_template.sub!("bp#{index}", " ")
        else
          @filled_template.sub!("bp#{index}", "#{black_captured[index-1].icon_code}")
        end
      end
    end

    def populate_last_moves
      if @game_state.moves.count.odd?
        last_moves = @game_state.moves.last(19)
        last_moves << "       "
      else
        last_moves = @game_state.moves.last(20)
      end
      last_turn = (@game_state.moves.count + 1) / 2
      index = 0

      until (last_black_move = last_moves.pop).nil?
        last_white_move = last_moves.pop
        @filled_template.sub!("t#{index}", "#{last_turn-index}  #{last_white_move.center(7)}  #{last_black_move.center(7)}")
        index += 1
      end

      while index < 10
        @filled_template.sub!("t#{index}", "")
        index += 1
      end
    end

    def populate_prompt
      if @game_state.active_player
        @filled_template.sub!("prompt", "#{@game_state.active_player.capitalize}, enter your command:\n")
      else
        @filled_template.sub!("prompt", "Press any key to return to menu\n")
      end
    end


  end
end
