class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate, :load_today_post
  helper_method :current_user
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

  def current_user
    User.find(session[:user_id]) if session[:user_id].present?
  end

  private
  def authenticate
  	@user = session[:user_id] = User.first
    @user = session[:user_id] = nil
  end

  def load_today_post
  	@post = @user.post_on if @user
  end
end
