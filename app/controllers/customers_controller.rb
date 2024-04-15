require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # ask the repository for all the customers
    customers = @customer_repository.all
    # give the customers to the view to display
    @customers_view.display(customers)
  end

  def add
    # ask view for customer name
    name = @customers_view.ask_for('name')
    # ask view for customer price
    address = @customers_view.ask_for('address')
    # create the customer instance
    customer = Customer.new(name: name, address: address)
    # give the instance to the repository
    @customer_repository.create(customer)
  end
end
