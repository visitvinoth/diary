module ApplicationHelper

	def welcome_message
		user = current_user
		if user
			"Welcome #{user.name}!!"
		else
			"Welcome to Diary!!!"
		end
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
