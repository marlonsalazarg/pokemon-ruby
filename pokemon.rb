require_relative "pokedex/pokemons"
require_relative "pokedex/moves"
class Pokemon
  attr_reader :name_pokemon, :type, :hp, :attack_p, :defense, :special_attack, :special_defense, :speed,
              :experience_points, :level, :individual_values, :effort_values, :exp_current
  attr_accessor :moves, :hp_current, :attack_current, :defense_current, :special_attack_current,
                :special_defense_current, :speed_current, :move_current, :stats, :level_current, :base_exp

  # (complete parameters)
  def initialize(name, specie, level)
    char_details = Pokedex::POKEMONS[specie.capitalize]
    @name_pokemon = name
    @specie = specie
    @level = level
    @type = char_details[:type]
    @hp = char_details[:base_stats][:hp]
    @attack_p = char_details[:base_stats][:attack]
    @defense = char_details[:base_stats][:defense]
    @special_attack = char_details[:base_stats][:special_attack]
    @special_defense = char_details[:base_stats][:special_defense]
    @speed = char_details[:base_stats][:speed]
    @experience_points = char_details[:base_exp]
    @moves = char_details[:moves]
    ###
    @base_exp = char_details[:base_exp]
    @effort_points = char_details[:effort_points]
    @growth_rate = char_details[:growth_rate]
    ###
    # Create instance variable with effort values. All set to 0
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @individual_stats = { hp: rand(0..31), attack: rand(0..31), defense: rand(0..31), special_attack: rand(0..31),
                          special_defense: rand(0..31), speed: rand(0..31) }
    @hp_current = 0
    @attack_current = 0
    @defense_current = 0
    @special_attack_current = 0
    @special_defense_current = 0
    @speed_current = 0
    @exp_current = 0
    @move_current = nil
    @exp_level_up = 0
    @gain_exp = 0
    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable

    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
    # ((2 * base_stat + stat_individual_value + stat_effort) * level / 100 + level + 10).floora
    @stats = {
      hp: ((((2 * @hp) + @individual_stats[:hp] + (@effort_values[:hp] / 4.0).floor) * @level / 100) + @level + 10).floor,
      attack: ((((2 * @attack_p) + @individual_stats[:attack] + (@effort_values[:attack] / 4.0).floor) * @level / 100) + 5).floor,
      defense: ((((2 * @defense) + @individual_stats[:defense] + (@effort_values[:defense] / 4.0).floor) * @level / 100) + 5).floor,
      special_attack: ((((2 * @special_attack) + @individual_stats[:special_attack] + (@effort_values[:special_attack] / 4.0).floor) * @level / 100) + 5).floor,
      special_defense: ((((2 * @special_defense) + @individual_stats[:special_defense] + (@effort_values[:special_defense] / 4.0).floor) * @level / 100) + 5).floor,
      speed: ((((2 * @speed) + @individual_stats[:speed] + (@effort_values[:speed] / 4.0).floor) * @level / 100) + 5).floor
    }
  end

  def prepare_for_battle
    @hp_current = @stats[:hp]
    @attack_current = @stats[:attack]
    @defense_current = @stats[:defense]
    @special_attack_current = @stats[:special_attack]
    @special_defense_current = @stats[:special_defense]
    @speed_current = @stats[:speed]
  end

  def receive_damage
    # Complete this
  end

  def set_current_move; end

  def fainted?
    @hp_current <= 0
  end

end
