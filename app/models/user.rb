class User < ActiveRecord::Base
  attr_accessible :active, :email, :name, :hashed_password, :salt
  has_many :posts
  def post_on(date = nil)
  	date ||= Date.today
  	posts.where(:entry_date => date).last
  end
  def self.create_raw(name, email, password)
    salt = BCrypt::Engine.generate_salt
    hashed_password = BCrypt::Engine.hash_secret(password, salt)
    User.create(:name => name, :email => email, :hashed_password => hashed_password, :active => true, :salt => salt)
  end
  def self.registered_user?(email)
    User.find_by_email(email).present?
  end
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user.present? && user.hashed_password == BCrypt::Engine.hash_secret(password , user.salt)
    return nil
  end
end
