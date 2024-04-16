class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.log_in
      while @employee
        # if the employee is a manager
        if @employee.manager?
          choice = display_manager_menu
          print `clear`
          manager_action(choice)
        else
          # if the employee is a rider
          choice = display_rider_menu
          print `clear`
          rider_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - Add a meal"
    puts "2 - List all meals"
    puts "3 - Add a customer"
    puts "4 - List all customers"
    puts "9 - Log out"
    puts "0 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def display_rider_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - Mark an order as delivered"
    puts "2 - List all undelivered orders"
    puts "9 - Log out"
    puts "0 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 9 then log_out
    when 0 then quit
    else
      puts "Try again..."
    end
  end

  def rider_action(choice)
    case choice
    when 1 then ''
    when 2 then ''
    when 9 then log_out
    when 0 then quit
    else
      puts "Try again..."
    end
  end

  def log_out
    @employee = nil
  end

  def quit
    log_out
    @running = false
  end
end
