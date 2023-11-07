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

 
end
