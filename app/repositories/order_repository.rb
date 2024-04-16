require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = [] # array of INSTANCES
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # everything from the CSV is a string
      # SO we need to convert non-string attrs
      attributes[:id] = attributes[:id].to_i
      attributes[:delivered] = attributes[:delivered] == 'true'
      attributes[:meal_id] = attributes[:meal_id].to_i
      attributes[:customer_id] = attributes[:customer_id].to_i
      attributes[:employee_id] = attributes[:employee_id].to_i
      attributes[:meal] = @meal_repository.find(attributes[:meal_id])
      attributes[:customer] = @customer_repository.find(attributes[:customer_id])
      attributes[:employee] = @employee_repository.find(attributes[:employee_id])
      order = Order.new(attributes)
      @orders << order
      @next_id = order.id + 1
    end
  end
end
