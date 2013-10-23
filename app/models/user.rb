class User < ActiveRecord::Base
  attr_accessible :active, :email, :hashed_password, :name
  has_many :posts
  def post_on(date = nil)
  	date ||= Date.today
  	posts.where(:entry_date => date).last
  end
end
