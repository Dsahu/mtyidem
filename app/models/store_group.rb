class StoreGroup < ActiveRecord::Base
  has_many :stores_in_groups
  has_many :stores, :through => :stores_in_groups
end
