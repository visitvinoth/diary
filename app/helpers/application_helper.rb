module ApplicationHelper
	def welcome_message
		user = current_user
		if user
			"Welcome #{user.name}!!"
		else
			"Welcome to Diary!!!"
		end
	end
end
