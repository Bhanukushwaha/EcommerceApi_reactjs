class ApplicationController < ActionController::Base
 skip_before_action :verify_authenticity_token
  helper_method :current_user
  def current_user
    if request.headers['Token'].present?
      header = request.headers['Token']
      begin
        User.find_by(authentication_token: header)
      rescue StandardError => e
        nil
      end
    else
      nil
    end
  end

  def authorize_request!
    return render json: { errors: "you are not unauthorized && you token has been expired" },status: :unprocessable_entity unless current_user.present?
  end
end
