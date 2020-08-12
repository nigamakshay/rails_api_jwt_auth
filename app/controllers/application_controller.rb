class ApplicationController < ActionController::API
  
  before_action :authenticate_request
  attr_reader :current_user

  private
  
  # Invoke every time when user makes a request
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end  
end
