module GetOptions
  def get_move_user(options, name_user)
    puts "#{name_user}, select your move:"
    puts ""
    # Prepare the Battle (print messages and prepare pokemons)
    movimientos = options
    movimientos.each_with_index do |move, index|
      print "#{index + 1}. #{move}      "
    end
    puts ""
    print "> "
    input = gets.chomp
    until movimientos.include?(input.downcase)
      print "> "
      input = gets.chomp
    end
    input
  end
end
