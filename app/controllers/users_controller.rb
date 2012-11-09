# require 'will_paginate'

class UsersController < ApplicationController
  before_filter :non_signed_in_user, only: [:new, :create]
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Char App!"
        # flash[:success] = "Well to the Char App!"
        redirect_to @user
      else
        render 'new'
      end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    # Not needed, due to before filter.
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
	# Note: this only works for single admin.
      an_admin = User.find_by_admin( true )
      # User.find(params[:id]).destroy
      this_user = User.find(params[:id])
      if( this_user == an_admin )
        flash[:error] = "Admin may not destroy self."
        redirect_to root_path # Only here so we can distinguish attempt of admin to destroy self in test
      else
        this_user.destroy 
        flash[:success] = "User destroyed."
        redirect_to users_path
      end
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  private
    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_url, notice: "Please sign in."
    #   end
    # end

        # added for exercise 6 in Section 9.6
    def non_signed_in_user
      if signed_in?
         redirect_to root_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
