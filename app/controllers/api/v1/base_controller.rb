class Api::V1::BaseController < ApplicationController

  include Pundit

  attr_accessor :current_user

  rescue_from Pundit::NotAuthorizedError, with: :deny_access # 使用 rescue_from 捕捉 Pundit::NotAuthorizedError 异常

  def api_error(opts = {})
    render response.status = opts[:status] #, text: "OAuth Error"
  end

  def deny_access
    api_error(status: 403)
  end

  def unauthenticated!
    api_error(status: 401)
  end


  def authenticate_user!

    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token) # 防止时序攻击(timing attack)
      self.current_user = user
    else
      return unauthenticated!
    end
  end

end
