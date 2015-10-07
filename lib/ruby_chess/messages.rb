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

  end
end
