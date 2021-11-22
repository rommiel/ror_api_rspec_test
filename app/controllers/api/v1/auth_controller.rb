class Api::V1::AuthController < ApiController

  def login 
    user = User.find_by(username: login_params[:username])
    user[:access_token] = ENV['ACCESS_TOKEN']

    if user && user.authenticate(login_params[:password])
      render json: {user: user}, status: :ok
    else
      render json: {error: "invalid credentials"}, status: :unauthorized
    end

    # Rspec: should have return 'user' and 'status' is OK
  end


  def create_user    
    # SecureRandom.hex() - use for some randomification

    if authenticate_user
      user = User.new(login_params)
      user[:access_token] = ENV['ACCESS_TOKEN']

      if user.save
        render json: {details: 'User successfully created', user: user}, status: :ok
      else
        render json: {error: "Error while saving user."}
      end
    else
      render json: {error: "not permitted"}, status: :unauthorized
    end
  end

  def authenticate_user 
    auth_header = request.headers['Authorization'] == ENV['ACCESS_TOKEN'] 
  end

  private

  def login_params
    params.permit(:username, :password)
  end

end
