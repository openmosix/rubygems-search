module SearchHelper

  def total_found(gems)
    (gems.respond_to? :total) ? "Found <em>#{gems.total}</em> results, showing <em>#{gems.count}</em>".html_safe : "Found <em>#{gems.count}</em> results.".html_safe
  end
  
end
