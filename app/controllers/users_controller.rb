class UsersController < ApplicationController
  # before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end
  # POST /users
   
  def create
    if (params[:user][:password] != params[:user][:password_confirmation])
      render json: {message: "password does not match?" }, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages.join(", ") },
        status: :unprocessable_entity
      end
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end
  private


  def user_params
    params.require(:user).permit( :email,  :password)
  end
end


