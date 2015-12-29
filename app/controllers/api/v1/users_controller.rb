class Api::V1::UsersController < Api::V1::BaseController

  before_action :authenticate_user!, only: [:update]

  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def update
    @user = User.find(params[:id])

    # return api_error(status: 403) if !UserPolicy.new(current_user, @user).update?
    authorize @user, :update? # pundit 提供了更简便的 authorize

    @user.update_attributes(update_params)

    render json: @user
  end

  private

    def update_params
      params.require(:user).permit(:name)
    end

end
