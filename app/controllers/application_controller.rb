 require 'bcrypt'
class ApplicationController < ActionController::Base

  include ApplicationHelper
  protect_from_forgery
  before_filter :authenticate, :load_today_post, :except => [:sign_up, :sign_in]
  helper_method :current_user
  
  def home
  end

  def enter
    if params[:commit] == "sign up"
      email = params[:email]
      name = params[:name]
      password = params[:password]
      render_home_with_message_and_return("Email already registered!!!", "Error") if User.registered_user?(email)
      @user = User.create_raw(name, email, password)
      if @user.valid?
        render_home_with_message_and_return("Successfully registered!! Please login to continue!!!")
      else
        render_home_with_message_and_return("Registration failed!! Try again!!!", "Error")
      end
    else
      email = params[:email]
      password = params[:password]
      user = User.authenticate(email, password)
      if user.present?
        session[:user_id] = user.id
        render_home_with_message_and_return("Successfully signed in!!")
      else
        render_home_with_message_and_return("Incorrect username or password!!", "Error")
      end
    end
  end
  
  def exit
    session[:user_id] = nil
    render_home_with_message_and_return("Successfully signed out!!")
  end

  def save_post
    if @user
      	if @post
	     	@post.entry_text = params[:entry_text]
  	     else
      		@post = @user.posts.new(:entry_text => params[:entry_text], :entry_date => Date.today)
  	     end
      	if @post.save
      		render :text => "Saved Successfully." and return
      	else
      		render :text => "Problem saving data." and return
      	end
      else
        render :text => "Problem saving data." and return
      end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id].present?
  end

  private
  def authenticate
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~SESSION: #{session}"
    if current_user.present?
      @user = current_user
      return true
    else
      return false
    end
  end

  def load_today_post
  	@post = @user.post_on if @user
  end

  def render_home_with_message_and_return(message, status = "Success")
    if status == "Success"
      flash[:notice] = message
      redirect_to :action => 'home'
    else
      flash[:error] = message
      redirect_to :action => 'home'
    end
  end

end
