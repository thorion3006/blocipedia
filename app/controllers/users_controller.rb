class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def role
    if @user.role == 'standard'
      @user.role = 'premium'
    elsif @user.role == 'premium'
      @user.role = 'standard'
    end
  end
end
