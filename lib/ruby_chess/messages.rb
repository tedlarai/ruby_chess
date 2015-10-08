module RubyChess
  module Messages
    def self.new_game
      "Game Started"
    end

    def self.invalid_command(command)
      "Invalid command: \"#{command}\". Please refer to the command list and try again."
    end

    def self.saved_game
      "Game saved"
    end

    def self.invalid_move_phrase(command)
      "Invalid move: \"#{command}\". "
    end

    def self.same_tile_move(command)
      invalid_move_phrase(command) + "Cannot move piece to same tile."
    end

    def self.empty_origin_tile(command)
      invalid_move_phrase(command) + "Tile #{command.split("-")[0]} is empty."
    end

    def self.wrong_color(command)
      invalid_move_phrase(command) + "Piece at #{command.split("-")[0]} is not yours!"
    end

    def self.capturing_own_piece(command)
      invalid_move_phrase(command) + "Cannot capture piece at #{command.split("-")[1]}, it's yours."
    end

    def self.piece_not_capable_of_move(piece, command)
      invalid_move_phrase(command) + "#{piece.class.to_s[8..-1]} not capable of this move."
    end

    def self.piece_not_capable_of_capture(piece, command)
      invalid_move_phrase(command) + "#{piece.class.to_s[8..-1]} not capable of this capture."
    end

    def self.piece_cannot_jump(piece, tile, command)
      invalid_move_phrase(command) + "#{piece.class.to_s[8..-1]} cannot jump piece at #{tile[0].to_s.tr("1-8", "a-h")}#{tile[1]}."
    end

    def self.king_near_other_king(command)
      invalid_move_phrase(command) + "King cannot be this near to the other king."
    end

    def self.own_king_in_check(command)
      invalid_move_phrase(command) + "Leaving own king in check."
    end

    def self.successful_move(command)
      "Moved successfully: \"#{command}\""
    end

    def self.victory(player)
      "\n   Checkmate!! Nice victory, #{player.capitalize}!!"
    end

    def self.draw
      "\n   What a pair of fierce competitors! It is a draw!"
    end

    def check
      "\n   Whoa, nice move! Check!"
    end
  end
end
