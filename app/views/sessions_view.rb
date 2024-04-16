class SessionsView
  # puts / gets

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username.capitalize}!"
  end

  def wrong_credentials
    puts "Wrong username or password"
  end
end
