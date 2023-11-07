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

  def print_battle_start
    puts "#{@bot.name} sent out #{@bot.pokemon_player.name_pokemon}!"
    puts "#{@player.name} sent out #{@player.pokemon_player.name_pokemon}!"
    puts "-------------------Battle Start!-------------------"
  end

  def base_stats_battle
    puts "#{@player.name}'s #{@player.pokemon_player.name_pokemon} - Level #{@player.pokemon_player.level}"
    puts "HP: #{@player.pokemon_player.hp_current}"
    puts "#{@bot.name}'s #{@bot.pokemon_player.name_pokemon} - Level #{@bot.level_pokemon}"
    puts "HP: #{@bot.pokemon_player.hp_current}"
  end

  def priority_attack(move_pokemon_player, movimientos_bot)
    tipo_move_player = move_pokemon_player
    tipo_move_bot = movimientos_bot
    arreglo_movimientos = [@poke_player, @poke_bot]
    if tipo_move_player[:priority] > tipo_move_bot[:priority]
      @poke_player
    elsif tipo_move_player[:priority] < tipo_move_bot[:priority]
      @poke_bot
    elsif @player.pokemon_player.speed > @bot.pokemon_player.speed
      @poke_player
    elsif @player.pokemon_player.speed < @bot.pokemon_player.speed
      @poke_bot
    else
      arreglo_movimientos.sample
    end
  end

  def separador
    puts "-" * 50
  end

end
