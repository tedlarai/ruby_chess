$: << File.dirname(__FILE__)

require "ruby_chess/move_validator"
require "ruby_chess/move_proccessor"
require "ruby_chess/game_controller"
require "ruby_chess/game_state"
require "ruby_chess/messages"
require "ruby_chess/ui"
require "ruby_chess/pieces/pawn"
require "ruby_chess/pieces/rook"
require "ruby_chess/pieces/knight"
require "ruby_chess/pieces/bishop"
require "ruby_chess/pieces/queen"
require "ruby_chess/pieces/king"
require "ruby_chess/pieces/pieces"
require "ruby_chess/menu"


include RubyChess
Menu.new.start
