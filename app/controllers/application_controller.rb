class ApplicationController < ActionController::Base
	protect_from_forgery

	def authenticate_user_or_student
		if current_student
			authenticate_student!
		else
			authenticate_user!
		end
	end

end
