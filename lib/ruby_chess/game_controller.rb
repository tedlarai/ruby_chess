module RubyChess
  class GameController
    def initialize
      @game_state = GameState.new
      @ui = UI.new(@game_state)
      @message = Messages.new_game
      game_loop
    end

    def game_loop
      loop do
        @ui.update_view(@message)
        game_turn
        turn_results
        @game_state.switch_active_player
      end
    end

    def game_turn
      command = gets.chomp
      proccess_command
    end

    def proccess_command

    end
  end
end
