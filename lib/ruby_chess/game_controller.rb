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
            if @message == Messages.promotion(command)
              promotion
            end
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
      delivered_check = @game_state.delivered_check?
      game_over = @game_state.game_over?
      if game_over
        if delivered_check # victory
          @message += Messages.victory(@game_state.active_player)
        else # draw
          @message += Messages.draw
        end
        @game_state.active_player = nil
        @ui.update_view(@message)
        gets
        quit_to_menu
      else # game_not_over
        if delivered_check
          @message += Messages.check
        end
      end
    end

    def promotion
      @ui.update_view(@message)
      command = ""
      loop do
        command = gets.chomp
        if command =~ /[qrbk]/
          break
        else
          @ui.update_view(Messages.invalid_promotion(command))
        end
      end
      @message = @game_state.proccess_promotion(command)
    end

    def save_game
      # save the game
      # update_view
    end

    def quit_to_menu
      exit
    end
  end
end
