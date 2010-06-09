class Store < ActiveRecord::Base
  has_many :ins_stores
  has_many :stores_in_groups
  has_many :inscriptions, :through => :ins_stores
end
