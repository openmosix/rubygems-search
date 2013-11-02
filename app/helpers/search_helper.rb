module SearchHelper

  def total_found(gems)
    (gems.respond_to? :total) ? "Found <em>#{gems.total}</em> results, showing <em>#{gems.count}</em>".html_safe : "Found <em>#{gems.count}</em> results.".html_safe
  end
  
  def replace_search_param(original_params, name, value)
    local_params = original_params.dup
    local_params[:search] ||= {}
    local_params[:search] = local_params[:search].dup
    local_params[:search][name] = value
    
    local_params
  end
  
  def original_search(params)
    params[:search] && params[:search][:q]
  end
  
end
