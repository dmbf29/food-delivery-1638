require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = [] # array of INSTANCES
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  # meal_repository.find(2) => instance of a meal
  def find(id)
    @meals.find do |meal|
      meal.id == id
    end
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # everything from the CSV is a string
      # SO we need to convert non-string attrs
      attributes[:id] = attributes[:id].to_i
      attributes[:price] = attributes[:price].to_i
      meal = Meal.new(attributes)
      @meals << meal
      @next_id = meal.id + 1
    end
  end
end
