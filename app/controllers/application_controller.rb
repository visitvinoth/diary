class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate, :load_today_post
  def home
  end

  def save_post
	if @post
		@post.entry_text = params[:entry_text]
  	else
  		@post = @user.posts.new(:entry_text => params[:entry_text], :entry_date => Date.today)
  	end
  	if @post.save
  		render :text => "Saved Successfully."
  	else
  		render :text => "Problem saving data."
  	end
  end

  private
  def authenticate
  	@user = User.first
  end
  def load_today_post
  	@post = @user.post_on
  end
end
