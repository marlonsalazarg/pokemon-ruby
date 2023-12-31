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

  # Inicio de metodos del menu
  def train(jugador, robot)
    battle_bot = Battle.new(jugador, robot)
    battle_bot.start
  end

  # def challenge_leader
  #   # Complete this
  # end

  def show_stats
    puts "Great #{@name_pokemon}"
    puts "Kind: #{@pokemon_chosen}"
    puts "Level: #{@player.pokemon_player.level}"
    puts "Type: #{@player.pokemon_player.type[0]}"
    puts "Stats:"
    @player.pokemon_player.stats.each do |key, value|
      puts "#{key.capitalize}: #{value}"
    end
    puts "Experience Points: #{@player.pokemon_player.exp_current}"
  end

  def goodbye
    puts "Thanks for playing Pokemon Ruby"
    puts "This game was created with love by: [Marlon Salazar, Ricardo Mendoza, Lau Lugo, Yull Timoteo]"
  end

  # def menu
  #   # Complete this
  # end

  def print_train(jugador, robot)
    puts "#{@name} challenge #{robot.name} for training"
    puts "#{robot.name} has a #{robot.aleatorio_bot_pokemon} level #{robot.level_pokemon}"
    puts "What do you want to do now?"
    puts ""
    puts "1. Fight        2. Leave"
    print "> "
    action = nil
    until action == "Leave"
      action = gets.chomp
      case action
      when "Fight"
        train(jugador, robot)
        break
      end
    end
    print_menu
  end

  def print_challenge_leader(jugador, leader)
    puts "#{@name} challenge the Gym Leader Brock for a fight!"
    puts "Brock has a Onix level 10"
    puts "What do you want to do now?"
    puts ""
    puts "1. Fight        2. Leave"
    print "> "
    action = nil
    until action == "Leave"
      action = gets.chomp
      case action
      when "Fight"
        train(jugador, leader)
        break
      end
    end
    print_menu
  end
end
