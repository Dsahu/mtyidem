class StoresInGroup < ActiveRecord::Base
  
  belongs_to :store
  belongs_to :store_group

end
