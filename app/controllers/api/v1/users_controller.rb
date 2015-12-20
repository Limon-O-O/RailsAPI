class Api::V1::UsersController < Api::V1::BaseController

  def show
    @user = User.find(params[:id])
    User.all.each {|user|
      user.password_digest = '123123'
      user.reset_auth_token!
    }
    render json: @user
  end

  def create
    users = User.create([
                   {
                     email: 'test-user-00@mail.com',
                     name: 'test-user-00',
                     activated: DateTime.now,
                     admin: false
                   },
                   {
                     email: 'test-user-01@mail.com',
                     name: 'test-user-01',
                     activated: DateTime.now,
                     admin: false
                   }
                  ])
  end

end
