module CurrentUser

	private 
		def set_user
			@user = User.find(session[:user_id])
		rescue ActiveRecord::RecordNotFound
			redirect_to login_url, alert: "You need to login first." 
		end

		def check_if_owner
	    	unless @pet.owned_by(@user)
	       		redirect_to @user, notice: 'You connot change other people pets data.'
	     	end
	    end

	    def check_if_current_user
	      unless @user.is_current_user(session[:user_id])
	        redirect_to welcome_index_url, notice: 'You cannot edit another users data.'
	      end
    	end

end