class GemsController < ApplicationController
  
  def index
    @gems = RubyGem.asc(:name).page(params[:page]).per(20)
  end
  
  def show
    @gem = RubyGem.find(params[:id])
  end
  
end
