class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  # POST /auth/login
  def login
    @user = User.where("email like ? ", params[:user][:email]).last
	    if @user.present? && @user.valid_password?(params[:user][:password])
	    	if @user.authentication_token.blank?
	    	  @user.update_column(:authentication_token, generate_auth_token)
	    	end
	      # time = Time.now + 24.hours.to_i
	      render json: { user: @user.reload}, status: :ok
	    else
	      render json: { error: 'Email and password incorrect' }, status: :unauthorized
	    end
    end
  private
  def generate_auth_token
  	loop do
     token = Devise.friendly_token
     break token unless User.find_by(authentication_token: token)
    end
  end
  def login_params
   params.require(:user).permit(:email, :password)
  end
end
