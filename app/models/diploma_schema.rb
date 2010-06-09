class DiplomaSchema < ActiveRecord::Base
  has_many :diploma_elements
  belongs_to :run
end
