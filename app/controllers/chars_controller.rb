class CharsController < ApplicationController
  def show
    @pinname = Pinname.find(params[:id])
  end

  def new
    @pinname = Pinname.new
    # @create = Pinname.new
    @char = @pinname
  end
end
