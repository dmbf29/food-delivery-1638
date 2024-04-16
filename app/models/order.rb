class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # INSTANCE
    @customer = attributes[:customer] # INSTANCE
    @employee = attributes[:employee] # INSTANCE
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  # order.deliver!
  def deliver!
    @delivered = true
  end

  def undelivered?
    !delivered?
  end
end
