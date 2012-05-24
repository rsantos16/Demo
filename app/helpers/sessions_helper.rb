module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remembered_token] = user.remembered_token
		current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user = nil
		cookies.delete(:remembered_token)
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remembered_token
	end

	private

		def user_from_remembered_token
			remembered_token = cookies[:remembered_token]
			User.find_by_remembered_token(remembered_token) unless remembered_token.nil?
		end
end
