class SessionController < ApplicationController
  before_action :require_login, except: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      session_params[:email], 
      session_params[:password]
    )

    if @user.nil?
      flash[:errors] = ['Invalid email or password.']
      render text: "nope"
    else
      login_user!(@user)
      redirect_to user_url(@user)
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
