class InsStore < ActiveRecord::Base
  belongs_to :store
  belongs_to :run
  has_many :inscriptions


  def to_s
    "#{self.name}"
  end
end
