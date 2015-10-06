module RubyChess
  module Messages
    def self.new_game
      "Game Started"
    end

    def self.invalid_command(command)
      "Invalid command: \"#{command}\". Please refer to the command list and try again."
    end
  end
end
