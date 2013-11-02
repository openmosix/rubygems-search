class GemsController < ApplicationController
  
  def index
    @gems = RubyGem.asc(:name).page(params[:page]).per(RubyGem::DEFAULT_SEARCH_SIZE)
  end
  
  def show
    @gem = RubyGem.find(params[:id])
  end
  
  def search
    redirect_to "/" and return unless params[:search].present? && params[:search][:q].present?
    
    search = RubyGem.simple_search(params[:search][:q], page: params[:page], facets: false)
    @gems = search.results
        
    render 'index'
  end
  
  def advanced_search
    params[:search] ||={}
    @show_advanced = true
    
    search = RubyGem.advanced_search(params[:search], page: params[:page])
    @gems = search.results
    
    render 'index'
  end
  
end
