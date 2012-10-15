class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Char App!"
      # flash[:success] = "Well to the Char App!"
      redirect_to @user
    else
      render 'new'
    end
  end

end
