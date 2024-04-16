class EmployeesView
  # puts / gets
  def display(employees)
    if employees.any?
      employees.each_with_index do |employee, index|
        puts "#{index + 1} #{employee.username}"
      end
    else
      puts "No employees yet 🍽️"
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end
end
