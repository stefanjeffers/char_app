class FormulasController < ApplicationController
    # Note: Will will not want all signed in users to be able to new/create/edit/update/destroy. Only show/index.
    # Only admin can do all of these. Same for pinnames controller.
  before_filter :signed_in_user, only: [:new, :create, :index, :edit, :update, :destroy]
  before_filter :admin_user,     only: [:new, :create,         :edit, :update, :destroy, :pinnames_for ]

  def show
    @formula = Formula.find(params[:id])
    
    # base     = @formula.base
    # offset   = @formula.offset
    # subindex = @formula.subindex
    # graph_id = @formula.graph_id
    # @pinname = Pinname.find_by_
  end

  def new
    @formula = Formula.new
  end

  def create 
    @formula = Formula.new(params[:formula])
    if @formula.save
      flash[:success] = "Thank you for the new formula information!"
      # flash[:success] = "Well to the Char App!"
      redirect_to @formula
    else
      # render 'add'
      render 'new'
    end
  end

  def edit
    @formula = Formula.find(params[:id])
  end

  def update
    @formula = Formula.find(params[:id])
    if @formula.update_attributes(params[:formula])
      # Handle a successful update.
      flash[:success] = "Formula data updated"
      redirect_to @formula
    else
      render 'edit'
    end
  end

  def index
    # @formulas = Formula.all
    @formulas = Formula.paginate(page: params[:page])
  end

  def destroy
    Formula.find(params[:id]).destroy
    flash[:success] = "Entry destroyed."
    redirect_to formulas_url
  end

  def pinnames_for
    @title    = "Names for current formulas"
    @formula  = Formula.find(params[:id])
    @pinnames = @formulas.pinnames
    render 'show_linked_to'
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


