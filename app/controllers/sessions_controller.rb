require_relative '../views/sessions_view'

# user actions
class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def log_in
    # tell the view to ask for username
    username = @sessions_view.ask_for('username')
    # tell the view to ask for password
    password = @sessions_view.ask_for('password')
    # ask the repository if this username exists
    employee = @employee_repository.find_by_username(username)
    # check the password of that user compared to the one given
    if employee && employee.password == password
      # if correct, welcome message
      @sessions_view.welcome(employee)
      return employee
    else
      # in incorrect, tell them the credentials are wrong
      @sessions_view.wrong_credentials
      log_in
    end
  end
end
