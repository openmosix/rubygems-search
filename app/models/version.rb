class Version
  include Mongoid::Document

  field :authors, type: String
  field :built_at, type: String
  field :description, type: String
  field :downloads_count, type: Integer
  field :number, type: String
  field :summary, type: String
  field :platform, type: String
  field :prerelease, type: Boolean
  field :licenses, type: Array  #of strings

  embedded_in :ruby_gem

  def to_indexed
    {built_at: built_at.to_date, number: number, description: description, summary: summary}
  end

end