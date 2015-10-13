module RubyChess
  class Menu
    def initialize
      @game = nil
      @message = Messages.welcome
    end

    def start
      loop do
        show_menu
        command = gets.chomp
        if command == '1'
          @game = GameController.new
          @game.game_loop
          @message = Messages.welcome
        elsif command == '2'
          begin
            @game = Marshal.load(File.read('saved_game'))
          rescue
            @message = Messages.no_saved_file
            next
          end
          @game.game_loop
          @message = Messages.welcome
        elsif command == '3'
          system('clear')
          exit
        else
          @message = Messages.invalid_command(command)
        end
      end
    end

    def show_menu
      system('clear')
      puts "#{@message}\n\n"
      puts "1...New Game"
      puts "2..Load Game"
      puts "3..Quit Game"
      print "\nEnter your option: "
    end

  end
end
