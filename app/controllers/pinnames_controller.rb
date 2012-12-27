class PinnamesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :index, :edit, :update, :destroy]
  before_filter :admin_user,     only: [:new, :create,         :edit, :update, :destroy, :formulas_for ]

  def show
    @pinname = Pinname.find(params[:id])
    @formulas = @pinname.formulas
  end

  def new
    @pinname = Pinname.new
  end

  def create 
    @pinname = Pinname.new(params[:pinname])
    if @pinname.save
      flash[:success] = "Thank you for the new character information!"
      # flash[:success] = "Well to the Char App!"
      redirect_to @pinname
    else
      # render 'add'
      render 'new'
    end
  end

  def edit
    @pinname = Pinname.find(params[:id])
  end

  def update
    @pinname = Pinname.find(params[:id])
    if @pinname.update_attributes(params[:pinname])
      # Handle a successful update.
      flash[:success] = "Character data updated"
      redirect_to @pinname
    else
      render 'edit'
    end
  end

  def index
    # @results = Pinname.search(params[:search])
    # @pinnames = Pinname.search_pinyin(params[:search])
    # @formulas = @pinnames.formulas.search_alpha(params[:search])
    # @pinnames = Pinname.all
    @pinnames = Pinname.paginate(page: params[:page])
  end

  def destroy
    Pinname.find(params[:id]).destroy
    flash[:success] = "Entry destroyed."
    redirect_to pinnames_url
  end

  def formulas_for
    @title = "Formulas for current name"
    @pinname = Pinname.find(params[:id])
    @formulas = @pinname.formulas
    render 'show_linked_to'
  end

  def search
    # @results = Pinname.search(params[:search])
    @pinnames = Pinname.search_pinyin(params[:search])
    # @formulas = @pinnames.formulas.search_alpha(params[:search])
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


