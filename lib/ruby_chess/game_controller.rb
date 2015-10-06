module RubyChess
  class GameController
    def initialize
      @game_state = GameState.new
      @ui = UI.new(@game_state)
      @ui.update_view(Messages.new_game)
    end
  end
end
