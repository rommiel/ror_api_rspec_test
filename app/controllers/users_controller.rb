class UsersController < ApplicationController
#class UsersController < ApiController
  def index
    render json: {test: "test"}, status: :ok
  end
end
