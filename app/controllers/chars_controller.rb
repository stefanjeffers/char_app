class CharsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :index, :edit, :update, :destroy]
  before_filter :admin_user,     only: [:new, :create,         :edit, :update, :destroy, :formulas_for ]

  def show
     @pinname = Pinname.find(params[:id])
     @formulas = @pinname.formulas
     # @char = Pinname.find(params[:id])
     # @formulas = @char.formulas
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
    # @chars = Pinname.paginate(page: params[:page])
    # @chars = Char.search(params[:search])
    # @results = Pinname.search_pinyin(params[:search])
	# When we add a chars model ( graph_id plus what?), move this into the model, a la railscast.
    if params[ :search ] && ( params[ :search ] != "" )
      # @results = Pinname.find.paginate(:all, :conditions => ['pinyin LIKE ?', "%#{params[ :search ]}%"])
      @results = Pinname.find(:all, :conditions => ['pinyin LIKE ?', "%#{params[ :search ]}%"])
	# Next, do something like: "@results.each{| result | append result.formula.alpha }
    else
	# This is wasteful. See how to create an empty list. Can't just be "nil". Array? or Hash? Try rails console.
      # find(:all)
      @results = Pinname.find(:all, :conditions => ['pinyin LIKE ?', "%xxx%"])
    end
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


