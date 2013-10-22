class User < ActiveRecord::Base
  attr_accessible :active, :email, :hashed_password, :name
end
