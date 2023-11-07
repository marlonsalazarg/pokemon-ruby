require_relative "pokemon"
require_relative "player"
require_relative "options"

class Battle
  include Pokedex
  attr_accessor :player, :bot, :move_pokemon_player, :movimientos_bot

  def initialize(player, bot)
    @player = player
    @bot = bot
    @poke_player = @player.pokemon_player
    @poke_bot = @bot.pokemon_player
  end

  def start
    @poke_player.prepare_for_battle
    @poke_bot.prepare_for_battle
    ##########################################
    bucle_battle
    winner = @poke_player.fainted? ? @poke_bot : @poke_player
    losser = winner == @poke_player ? @poke_bot : @poke_player
    battle_end(winner.name_pokemon, losser.name_pokemon)
    @poke_player.increase_stats(losser) if @poke_player == winner
    return unless @bot.name == "Brock" && @poke_bot == losser

    puts "Congratulation! You have won the game!"
    puts "You can continue training your Pokemon if you want"

    # Until one pokemon faints
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats
  end

end
