class Mastermind
  include Enumerable

  def initialize
    @@game_array = ["pink", "blue", "green", "purple", "yellow", "orange"]
    @guesses_array = []
    instructions
    player_setup
  end

  def player_setup
    puts "Would you like to be the code-maker or the code-breaker?
          Enter 1 to be the code-maker.
          Enter 2 to be the code-breaker."
    player_part = gets.chomp.to_i
    if player_part == 1
      user_is_maker
    elsif player_part == 2
      user_is_breaker
    end
  end

  def set_this_game_array
    @@this_game = @@game_array.shuffle
    @@this_game.pop(2)
  end

  def user_is_breaker
      set_this_game_array
      get_input
      play
  end

  def user_is_maker
    set_code
    computer_play
  end

  def set_code
    puts "Enter a color for the first position."
    one = compare_input (gets.chomp.downcase)
    puts "Enter a color for the second position."
    two = compare_input (gets.chomp.downcase)
    puts "Enter a color for the third position."
    three = compare_input (gets.chomp.downcase)
    puts "Enter a color for the fourth position."
    four = compare_input (gets.chomp.downcase)

    @users_code = [one, two, three, four]
  end

  def computer_play
    count = 0
    12.times do
      count += 1
      set_this_game_array
      compile_guesses_array(@@this_game)
      puts count
      @users_code.each.with_index do |user_value, user_index|
        @@this_game.each.with_index do |value, index|
          if user_value == value && user_index == index
            defined?(@a_num) ? @a_num += 1 : @a_num = 1
            next
          elsif user_value == value #|| guess_index == index
            defined?(@num) ? @num += 1 : @num = 1
            break
          end
        end
      end

      puts "    The computer has #{@a_num} correct" if defined? (@a_num)
      puts "    The computer is partially correct on #{@num} guess(es)" if defined? (@num)
      puts @guesses_array
      if @a_num == 4
        puts "    The computer has won!!"
        break
      elsif count == 12
        puts "    Game Over."
        play_again
      else
        puts "    The computer guesses again."
        remove_instance_variable(:@num) if defined? (@num)
        remove_instance_variable(:@a_num) if defined? (@a_num)
        redo
      end
    end
  end

  def play
    count = 0
    3.times do
      count += 1
      @guess_array.each.with_index do |guess_value, guess_index|
        @@this_game.each.with_index do |value, index|
          if guess_value == value && guess_index == index
            defined?(@a_num) ? @a_num += 1 : @a_num = 1
            next
          elsif guess_value == value #|| guess_index == index
            defined?(@num) ? @num += 1 : @num = 1
            break
          end
        end
      end
      puts "    You have #{@a_num} correct" if defined? (@a_num)
      puts "    You are partially correct on #{@num} guess(es)" if defined? (@num)
      puts @guesses_array
      if @a_num == 4
        puts "    We have a winner!!"
        play_again
      elsif count == 3
        puts "    Game Over."
        play_again
      else
        puts "    Guess Again."
        remove_instance_variable(:@num) if defined? (@num)
        remove_instance_variable(:@a_num) if defined? (@a_num)
        get_input
      end
    end
  end

  def play_again
    remove_instance_variable(:@num) if defined? (@num)
    remove_instance_variable(:@a_num) if defined? (@a_num)
    puts "Would you like to play again?\n\nType 'Y' or 'N'"
    if gets.chomp.upcase == "Y"
      initialize
    else
      exit
    end
  end

  def compare_input (user_guess)
    result = false
    @@game_array.each do |color|
      if color == user_guess
        result = true
        break
      end
    end
    if result == false
      puts "Input not valid, please try again."
      user_guess = gets.chomp.downcase
      compare_input(user_guess)
    end
    return user_guess
  end

  def instructions
    puts "Welcome to Mastermind!

    How to Play:
    The code maker chooses 4 colors out of 6 possible and places them in
    positions 1-4.

    The code breaker tries to guess what color and positions have been set.
    She/he chooses 4 colors out of 6 possible and places them in positions 1-4.

    The 2 codes are analyzed for matches and the code breaker is given feedback
    when she/he has placed a perfect match or a partial match.

    A perfect match is the same color in the same location that was set by the code-maker.
    A partial match is the same color but not in the same location as the code-maker's code.

    Color choices are pink, blue, purple, yellow, green and orange.\n\n"
  end

  def get_input
    puts "Enter the color of your first guess."
    one = compare_input (gets.chomp.downcase)
    puts "Enter the color of your second guess."
    two = compare_input (gets.chomp.downcase)
    puts "Enter the color of your third guess."
    three = compare_input (gets.chomp.downcase)
    puts "Enter the color of your fourth guess."
    four = compare_input (gets.chomp.downcase)

    @guess_array = [one, two, three, four]
    compile_guesses_array(@guess_array)
  end

  def compile_guesses_array(new_array)
    @guesses_array.push(new_array.join(" | "))
  end
end
Mastermind.new
