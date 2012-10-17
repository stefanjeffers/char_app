class PinnamesController < ApplicationController
  def show
    @pinname = Pinname.find(params[:id])
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

end


