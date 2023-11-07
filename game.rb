require_relative "pokedex/pokemons" # Importación de galeria Pokemons
require_relative "pokemon" # Importación de clase Pokemon
require_relative "player" # Importación de clase Player
require_relative "battle" # Importación de clase Battle
class Game
  attr_reader :name, :pokemon_chosen, :name_pokemon, :type

  include GetOptions
  include Pokedex

  def initialize
    @name = ""
    @lista_pokemon = Pokedex::POKEMONS
    @pokemones = @lista_pokemon.keys
    @pokemon_chosen = ""
    ###
    @level_pokemon = 1
    #####
  end

  def start
    name_asign
    choose_pokemon
    @player = Player.new(@name, @name_pokemon, @pokemon_chosen, @level_pokemon)
    menu_functions
  end

  def print_pokemons
    initial_pokemons = Pokedex::POKEMONS.select { |_name, data| data[:growth_rate] == :medium_slow }
    @pokemons_medium_slow = initial_pokemons.keys
    @pokemons_medium_slow.each_with_index do |name, index|
      print " #{index + 1}. #{name}       "
    end
    puts ""
  end

  def print_menu
    puts "#{'-' * 26}Menu#{'-' * 26}\n\n"
    puts "1. Stats        2. Train        3. Leader       4. Exit"
  end

  # Display interfaz
  def name_asign
    print "#{"#\$" * 30}\n"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts "#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts ("#\$" * 30).to_s
    puts ""
    puts "Hello there! Welcome to the world of POKEMON! My name is OAK!"
    puts "People call me the POKEMON PROF!\n\n"
    puts "This world is inhabited by creatures called POKEMON! For some"
    puts "people, POKEMON are pets. Others use them for fights. Myself..."
    puts "I study POKEMON as a profession."
    puts "First, what is your name?"
    while @name.empty?
      print "> "
      @name = gets.chomp
    end
    puts ""
    puts "Right! So your name is #{@name.upcase}!"
  end

  def choose_pokemon
    puts "Your very own POKEMON legend is about to unfold! A world of"
    puts "dreams and adventures with POKEMON awaits! Let's go!"
    puts "Here, #{@name.upcase}! There are 3 POKEMON here! Haha!"
    puts "When I was young, I was a serious POKEMON trainer."
    puts "In my old age, I have only 3 left, but you can have one! Choose!\n\n"

    print_pokemons

    until @pokemons_medium_slow.include?(@pokemon_chosen.capitalize)
      print "> "
      @pokemon_chosen = gets.chomp
    end
    @pokemon_chosen.capitalize!
    puts ""
    puts "You selected #{@pokemon_chosen}. Great choice!"
    puts "Give your pokemon a name?"
    print "> "
    @name_pokemon = gets.chomp
    @name_pokemon = @name_pokemon.empty? ? @pokemon_chosen : @name_pokemon

    puts "#{@name.upcase}, raise your young #{@name_pokemon.upcase} by making it fight!"
    puts "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"

    print_menu
  end

  def menu_functions
    action = nil
    until action == "Exit"
      print "> "
      action = gets.chomp
      case action
      when "Train"
        bot = Bot.new
        print_train(@player, bot)
      when "Leader"
        leader = Leader.new
        print_challenge_leader(@player, leader)

      when "Stats"
        show_stats
        print_menu
      when "Exit" then goodbye
      end

    end
  end

  
end
