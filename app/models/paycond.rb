class Paycond < ActiveRecord::Base
  belongs_to :runevent
  
  def amount_total
    amount + amount_extra
  end
end
