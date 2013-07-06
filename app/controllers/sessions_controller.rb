class SessionsController < ApplicationController
	def new
	end
	def create
		user=User.find_by_email(params[:sessions][:email])
		if user && user.authenticate(params[:sessions][:password])
			sign_in user
			flash.now[:success]="Welcome to sample app"
			redirect_to root_url
		else
			flash[:error]="Invalid username/password"
			redirect_to root_url
		end			
	end

	def destroy
		sign_out
		flash[:success]="Successfully signed-out"
		redirect_to root_url
	end
	
end
