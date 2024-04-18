class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.attribute(x,y)
  end
end
