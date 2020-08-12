class AuthenticateUser
  prepend SimpleCommand # Alias method of simple command

  # Invoked when simple command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Returns the result of API authentication
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  # Authenticate and returns the user
  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password) # authenticate method is available because "has_secure_password" is added in user model

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end