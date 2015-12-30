class Api::V2::UsersController < Api::V1::BaseController
  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
