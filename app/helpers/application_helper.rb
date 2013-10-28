module ApplicationHelper

	def welcome_message
		user = current_user
		if user
			"<span id = 'user_name_link'> Welcome #{user.name}!! </span>".html_safe
		else
			"Welcome to Diary!!!"
		end
	end

	def edit_profile_contents 
		"<a href = '/exit'>Sign out </a>".html_safe
	end

	def show_fash
		flash_msg = ""
		if flash[:notice].present?
			flash_msg = "<input type = 'hidden' id = 'flash_notice' value = '#{flash[:notice]}'/>"
		elsif flash[:error].present?
			flash_msg = "<input type = 'hidden' id = 'flash_error' value = '#{flash[:error]}'/>"
		end
		return flash_msg
	end
end
