class Post < ActiveRecord::Base
  attr_accessible :entry_date, :entry_text, :user_id
end
