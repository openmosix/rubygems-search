module SearchHelper

  def total_found(gems)
    (gems.respond_to? :total) ? "Found #{gems.total} results, showing #{gems.count}" : "Found #{gems.count} results."
  end
  
end
