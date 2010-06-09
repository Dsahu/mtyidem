class Response < ActiveRecord::Base

  belongs_to :wallevent
  belongs_to :result
  belongs_to :by_user, :class_name => "User", :foreign_key => "by_user_id"
  belongs_to :user
end
