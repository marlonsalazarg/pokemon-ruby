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

  def attack(target)
    # Print attack message 'Tortuguita used MOVE!'
    puts "#{@name_pokemon} used #{@move_current[:name]}!"
    # Accuracy check
    hit = rand(1..100) <= @move_current[:accuracy]
    # If the movement is not missed
    if hit
      # -- Calculate base damage
      damage = ((((2 * @level / 5.0) + 2).floor * offensive_stat(@move_current[:type],
                                                                 target.type) * @move_current[:power] / target_defensive_stat(target)).floor / 50.0).floor + 2
      # -- Critical Hit check
      critical = rand(1..16) == 16
      if critical
        current_damage = damage * 1.5
        puts "It was CRITICAL hit!"
      else
        current_damage = damage
      end
      effectiveness = offensive_stat(@move_current[:type], target.type)
      case effectiveness
      when 0.5
        current_damage *= 0.5
        puts "It's not very effective..."
      when 2
        current_damage *= 2
        puts "It's super effective!"
      when 0
        current_damage *= 0
        puts "It doesn't affect #{target.name_pokemon}!"
      else
        current_damage *= 1
      end
      target.hp_current -= current_damage.floor
      puts "And it hit #{target.name_pokemon} with #{current_damage.floor} damage"

    else
      puts "But it MISSED!"
    end

    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    # -- Effectiveness check
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"
  end

end
