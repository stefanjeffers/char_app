class FormulasController < ApplicationController
    # Note: Will will not want all signed in users to be able to new/create/edit/update/destroy. Only show/index.
    # Only admin can do all of these. Same for pinnames controller.
  before_filter :signed_in_user, only: [:new, :create, :index, :edit, :update, :destroy]
  before_filter :admin_user,     only: [:new, :create,         :edit, :update, :destroy]

  def show
    @Formula = Formula.find(params[:id])
  end

  def new
    @Formula = Formula.new
  end

  def create 
    @Formula = Formula.new(params[:Formula])
    if @Formula.save
      flash[:success] = "Thank you for the new formula information!"
      # flash[:success] = "Well to the Char App!"
      redirect_to @Formula
    else
      # render 'add'
      render 'new'
    end
  end

  def edit
    @Formula = Formula.find(params[:id])
  end

  def update
    @Formula = Formula.find(params[:id])
    if @Formula.update_attributes(params[:Formula])
      # Handle a successful update.
      flash[:success] = "Formula data updated"
      redirect_to @Formula
    else
      render 'edit'
    end
  end

  def index
    # @Formulas = Formula.all
    @Formulas = Formula.paginate(page: params[:page])
  end

  def destroy
    Formula.find(params[:id]).destroy
    flash[:success] = "Entry destroyed."
    redirect_to Formulas_url
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def admin_user
      # redirect_to(root_path) unless current_user.admin?
      redirect_to( user_path( current_user )) unless current_user.admin?
    end

end


