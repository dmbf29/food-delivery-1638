require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # ask the repository for all the meals
    meals = @meal_repository.all
    # give the meals to the view to display
    @meals_view.display(meals)
  end

  def add
    # ask view for meal name
    name = @meals_view.ask_for('name')
    # ask view for meal price
    price = @meals_view.ask_for('price').to_i
    # create the meal instance
    meal = Meal.new(name: name, price: price)
    # give the instance to the repository
    @meal_repository.create(meal)
  end
end
