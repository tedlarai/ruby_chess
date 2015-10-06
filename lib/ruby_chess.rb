$: << File.dirname(__FILE__)

require "ruby_chess/game_controller"
require "ruby_chess/game_state"
require "ruby_chess/messages"
require "ruby_chess/ui"
require "ruby_chess/pieces/pawn"

include RubyChess
GameController.new
