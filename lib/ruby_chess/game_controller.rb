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
        get_command
        turn_results
        @game_state.switch_active_player
      end
    end

    def get_command
      loop do
        command = gets.chomp
        if (command =~ /\A[a-h][1-8][-][a-h][1-8]\z/ || command == "0-0" || command == "0-0-0")
          validity_with_message = @game_state.proccess_move(command)
          @message = validity_with_message[:message]
          if validity_with_message[:validity]
            break
          else
            @ui.update_view(@message)
            next
          end
        elsif command == "s"
          save_game
          @message = Messages.saved_game
          @ui.update_view(@message)
          next
        elsif command == "q"
          exit
        else
          @message = Messages.invalid_command(command)
          @ui.update_view(@message)
          next
        end
      end
    end

    def turn_results

    end

    def save_game
      # save the game
      # update_view
    end
  end
end
