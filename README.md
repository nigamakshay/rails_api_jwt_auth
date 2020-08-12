
Usage of JWT authentication for RAILS API


Steps -

  * Create project
    command - rails new rails_api_jwt_auth --api

  * Create user model
    command - rails g model User name email password_digest

  * Run migration
    command - rails db:migrate

  * Add password encryption gem
    in Gemfile - gem 'bcrypt', '~> 3.1.7'  

  * Install bundle
    command - bundle install

  * Add method has_secure_password in User model to encrypt the password, password_digest field is already added while creating user model    
    in user.rb add - has_secure_password

  * Add jwt gem
    in Gemfile - gem 'jwt'
  
  * Install bundle
    command - bundle install

  * Create file json_web_token.rb under lib folder

  * Load lib content when application is loaded
    add in config/application.rb - config.autoload_paths << Rails.root.join('lib')

  * Create service using simple_command gem for connection between model and controller rather than controller and view
    in Gemfile - gem 'simple_command'

  * Install bundle
    command - bundle install

  * Create file - app/commands/authenticate_user.rb
    add alias method of simple command in above file - prepend SimpleCommand  
  
  * Create file - authorize_api_request.rb
    add method to decode authorization header

  * Create file - app/controllers/authentication_controller.rb   
    add authentication and returns JWT token to the user

  * add path
    In config/routes.rb - post 'authenticate', to: 'authentication#authenticate'

  * add current user method and before_action to authenticate_request    
    In application_controller.rb to available in all controllers


Does it work?
  * start console
    command - rails c

  * Create a user
    command - User.create!(email: 'akshay@mail.com' , password: 'testingAPI' , password_confirmation: 'testingAPI')   

  * Add a resource
    command - rails g scaffold Item name:string description:text 

  * Migrate
    command - rails db:migrate

  * Start the server and make authentication request  
    command - curl -H "Content-Type: application/json" -X POST -d '{"email":"akshay@mail.com","password":"testingAPI"}' http://localhost:3000/authenticate
    returns the token - {"auth_token":"asdasAiOadaTHfefe45JIUzIDFD34sf.eyJ1c2VyvdfSDFjEASDAEGH9.xsSwcDADE34236bU_OGCSyfE89DdADEMA"}

  * Make resource request without authentication token
    command - curl http://localhost:3000/items
    returns error - {"error":"Not Authorized"}
  
  * Make resource request with authentication token
    command - $ curl -H "Authorization: {authentication token goes here}" http://localhost:3000/items
    returns - [], empty array because resource is not added yet

  Worked!
