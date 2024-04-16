require_relative '../views/employees_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
    @orders_view = OrdersView.new
  end

  def add
    # we need to get the meals from the repo
    # tell the view to display the meals
    # tell view to ask for the order number
    # get the instance using the number
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meal = meals[index]

    # we need to get the customers from the repo
    # tell the view to display the customers
    # tell view to ask for the order number
    # get the instance using the number
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customer = customers[index]

    # we need to get the riders from the repo
    # tell the view to display the employees
    # tell view to ask for the order number
    # get the instance using the number
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    employee = employees[index]

    # create an instance of an order .new
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # add it to the repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # we need the undelivered order from the repository
    orders = @order_repository.undelivered_orders
    # give the orders to the view for display
    @orders_view.display(orders)
  end

  def list_my_undelivered_orders(employee)
    # we need the undelivered orders from the repository
    orders = @order_repository.my_undelivered_orders(employee)
    # give the orders to the view for display
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # display the orders for that employee
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    # ask the user which one did you just deliver?
    index = @orders_view.ask_for('number').to_i - 1
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
