require_relative "pokedex/moves"
require_relative "pokedex/pokemons"
require_relative "battle"
require_relative "pokemon"
require_relative "options"
class Player
  include Pokedex
  include GetOptions
  attr_accessor :name, :pokemon_player, :aleatorio_bot_pokemon, :level_pokemon, :select_move

  def initialize(name_player, name_pokemon, pokemon_chosen, level)
    @name = name_player
    @level_pokemon = level
    @pokemon_player = Pokemon.new(name_pokemon, pokemon_chosen, level)
  end

  def select_move
    movimientos = get_move_user(@pokemon_player.moves, @name)
    @pokemon_player.move_current = Pokedex::MOVES[movimientos]
  end
end

# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  def initialize
    bot_pokemon = Pokedex::POKEMONS.keys
    @aleatorio_bot_pokemon = bot_pokemon.sample
    super("Ramdom Person", @aleatorio_bot_pokemon, @aleatorio_bot_pokemon, rand(1..5))
  end

  def select_move
    movimientos_bot = @pokemon_player.moves
    rand_mov_bot = movimientos_bot.sample
    @pokemon_player.move_current = Pokedex::MOVES[rand_mov_bot]
  end
end


end
