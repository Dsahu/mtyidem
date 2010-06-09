class Email < ActiveRecord::Base

  belongs_to :user

  DIRECTORY = 1
  DIRECTORY_HOTMAIL = 2
  DIRECTORY_GMAIL = 3
  DIRECTORY_YAHOO = 4

  MANUAL = 10

  

end
