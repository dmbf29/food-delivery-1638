class MealsView
  # puts / gets
  def display(meals)
    if meals.any?
      meals.each_with_index do |meal, index|
        puts "#{index + 1} #{meal.name} ¥#{meal.price}"
      end
    else
      puts "No meals yet 🍽️"
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end
end
