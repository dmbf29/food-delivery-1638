require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = [] # array of INSTANCES
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end

  # @employee_repository.find_by_username('vincent')
  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # everything from the CSV is a string
      # SO we need to convert non-string attrs
      attributes[:id] = attributes[:id].to_i
      employee = Employee.new(attributes)
      @employees << employee
    end
  end
end
